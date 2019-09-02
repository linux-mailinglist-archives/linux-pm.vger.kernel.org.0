Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 973FEA5D70
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 23:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfIBVTj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 17:19:39 -0400
Received: from onstation.org ([52.200.56.107]:51240 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbfIBVTi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Sep 2019 17:19:38 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 08CEF3E993;
        Mon,  2 Sep 2019 21:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1567459178;
        bh=bIb25bI6AK5yndv+YyL9u3f0a+M90BALHovQZTHTWBc=;
        h=From:To:Cc:Subject:Date:From;
        b=XXemhwxfXwCS+j40ANEYmNnWWJ8Dkcnad071I5isqDWZIWhEfCtQ2EmdK6XRkjC31
         AGRZGVpfp/8/wXjB8HkRnnuky2hIUN68dybjIWrb7TpzPQkXZWm/egR+bWs5HhAW7k
         oJK2IqPu2wHgtwCpgq2V/UPg5Xonm9dbnPVKPq3s=
From:   Brian Masney <masneyb@onstation.org>
To:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/2] interconnect: qcom: add msm8974 driver
Date:   Mon,  2 Sep 2019 17:19:23 -0400
Message-Id: <20190902211925.27169-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Here's a patch series that adds interconnect support for the Qualcomm
MSM8974, which is needed so that the GPU can be supported upstream. I'm
having an issue with getting this to work fully and included a detailed
write up in patch 2 with what I'm seeing. I think I am close to
getting this working fully and would appreciate any feedback on this
series.

Brian Masney (2):
  dt-bindings: interconnect: qcom: add msm8974 bindings
  interconnect: qcom: add msm8974 driver

 .../bindings/interconnect/qcom,msm8974.yaml   | 163 ++++
 drivers/interconnect/qcom/Kconfig             |   9 +
 drivers/interconnect/qcom/Makefile            |   2 +
 drivers/interconnect/qcom/msm8974.c           | 793 ++++++++++++++++++
 .../dt-bindings/interconnect/qcom,msm8974.h   | 146 ++++
 5 files changed, 1113 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
 create mode 100644 drivers/interconnect/qcom/msm8974.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8974.h

-- 
2.21.0

