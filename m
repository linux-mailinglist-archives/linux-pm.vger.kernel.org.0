Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90417159D89
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 00:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgBKXis (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 18:38:48 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:60663 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgBKXis (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 18:38:48 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id c23d69b279245a74; Wed, 12 Feb 2020 00:38:46 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH 18/28] drivers: media: Call cpu_latency_qos_*() instead of pm_qos_*()
Date:   Wed, 12 Feb 2020 00:17:51 +0100
Message-ID: <4139443.DiSibVL1GN@kreacher>
In-Reply-To: <1654227.8mz0SueHsU@kreacher>
References: <1654227.8mz0SueHsU@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Call cpu_latency_qos_add/remove_request() instead of
pm_qos_add/remove_request(), respectively, because the
latter are going to be dropped.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/media/pci/saa7134/saa7134-video.c | 5 ++---
 drivers/media/platform/via-camera.c       | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/media/pci/saa7134/saa7134-video.c b/drivers/media/pci/saa7134/saa7134-video.c
index 342cabf48064..a8ac94fadc14 100644
--- a/drivers/media/pci/saa7134/saa7134-video.c
+++ b/drivers/media/pci/saa7134/saa7134-video.c
@@ -1008,8 +1008,7 @@ int saa7134_vb2_start_streaming(struct vb2_queue *vq, unsigned int count)
 	 */
 	if ((dmaq == &dev->video_q && !vb2_is_streaming(&dev->vbi_vbq)) ||
 	    (dmaq == &dev->vbi_q && !vb2_is_streaming(&dev->video_vbq)))
-		pm_qos_add_request(&dev->qos_request,
-			PM_QOS_CPU_DMA_LATENCY, 20);
+		cpu_latency_qos_add_request(&dev->qos_request, 20);
 	dmaq->seq_nr = 0;
 
 	return 0;
@@ -1024,7 +1023,7 @@ void saa7134_vb2_stop_streaming(struct vb2_queue *vq)
 
 	if ((dmaq == &dev->video_q && !vb2_is_streaming(&dev->vbi_vbq)) ||
 	    (dmaq == &dev->vbi_q && !vb2_is_streaming(&dev->video_vbq)))
-		pm_qos_remove_request(&dev->qos_request);
+		cpu_latency_qos_remove_request(&dev->qos_request);
 }
 
 static const struct vb2_ops vb2_qops = {
diff --git a/drivers/media/platform/via-camera.c b/drivers/media/platform/via-camera.c
index 78841b9015ce..1cd4f7be88dd 100644
--- a/drivers/media/platform/via-camera.c
+++ b/drivers/media/platform/via-camera.c
@@ -646,7 +646,7 @@ static int viacam_vb2_start_streaming(struct vb2_queue *vq, unsigned int count)
 	 * requirement which will keep the CPU out of the deeper sleep
 	 * states.
 	 */
-	pm_qos_add_request(&cam->qos_request, PM_QOS_CPU_DMA_LATENCY, 50);
+	cpu_latency_qos_add_request(&cam->qos_request, 50);
 	viacam_start_engine(cam);
 	return 0;
 out:
@@ -662,7 +662,7 @@ static void viacam_vb2_stop_streaming(struct vb2_queue *vq)
 	struct via_camera *cam = vb2_get_drv_priv(vq);
 	struct via_buffer *buf, *tmp;
 
-	pm_qos_remove_request(&cam->qos_request);
+	cpu_latency_qos_remove_request(&cam->qos_request);
 	viacam_stop_engine(cam);
 
 	list_for_each_entry_safe(buf, tmp, &cam->buffer_queue, queue) {
-- 
2.16.4





