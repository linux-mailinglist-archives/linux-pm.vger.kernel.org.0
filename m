Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECA11154ED
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 17:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfLFQRG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Dec 2019 11:17:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43273 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbfLFQRG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Dec 2019 11:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575649024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9FcmzKbZjToAadhOdw0aqboYZH5PpSClOXPEco7jAnA=;
        b=Ay+tdUYqts4l+k2LF05M818KXfFehbDiAq4j9Y+iXZHIlDYFOay0DIQlapbVazcIa6ZSEz
        Jt92SLwVgkxb1gfkRq1tejmOp0AraHa+nqr7wCdAE9CVZmWWV+RE6fSPxckywFln5Km5er
        sbhwoSXEkjkxfLZmJ5rFQBhWvXA272I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-AMpQHCkJMmOxhJumF-3VZw-1; Fri, 06 Dec 2019 11:16:59 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DFB11B18BDC;
        Fri,  6 Dec 2019 16:16:58 +0000 (UTC)
Received: from amt.cnet (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 206B886B80;
        Fri,  6 Dec 2019 16:16:58 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
        by amt.cnet (Postfix) with ESMTP id 56F5E1004E6;
        Fri,  6 Dec 2019 13:07:45 -0200 (BRST)
Received: (from marcelo@localhost)
        by amt.cnet (8.14.7/8.14.7/Submit) id xB6F7fo9028164;
        Fri, 6 Dec 2019 13:07:41 -0200
Date:   Fri, 6 Dec 2019 13:07:41 -0200
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] cpuidle: use first valid target residency as poll time
Message-ID: <20191206150739.GA20167@amt.cnet>
MIME-Version: 1.0
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: AMpQHCkJMmOxhJumF-3VZw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


commit 259231a045616c4101d023a8f4dcc8379af265a6 changed, by mistake,
the target residency from the first available sleep state to the last
available sleep state (which should be longer).

This might cause excessive polling.

Fixes: 259231a045616c4101d023a8f4dcc8379af265a6

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 0005be5ea2b4..15877b431143 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -382,6 +382,7 @@ u64 cpuidle_poll_time(struct cpuidle_driver *drv,
 =09=09=09continue;
=20
 =09=09limit_ns =3D (u64)drv->states[i].target_residency_ns;
+=09=09break;
 =09}
=20
 =09dev->poll_limit_ns =3D limit_ns;

