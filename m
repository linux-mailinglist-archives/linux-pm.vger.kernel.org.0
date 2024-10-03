Return-Path: <linux-pm+bounces-15096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE0E98EC20
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 11:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3782F284A78
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 09:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6D41422C7;
	Thu,  3 Oct 2024 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tH9j27wM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D2A4964D;
	Thu,  3 Oct 2024 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727946932; cv=none; b=KjCzYCS/uCEQNa3I5Qdj3S+/STgZp6aJ3dRdUqvphVLTBxAX1domIhRPIuOr9cyvo00NKPy9BLA7BJufRRl9wwhCveSDYsYLAiw+Ps8WPsgckxjJ/fefJ8Kl/7KWQfCNB4HIirH9YvaXqJIoG/bHvIXUs0ATWm4zkNfToxYnHIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727946932; c=relaxed/simple;
	bh=T9H1KMDW70Adce/wHpy4xVCVjuWFRo8miSFkI/PSAmI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=fr7BjkssnLyoTvHha2SNJxACuGctiEGTHo5f9SPe21XQI/4nziGxZRxOJ2SHD5Fb7Cm0DdaXdh7ZEXZqfWNfbs7IsxvN9S5262+N6tF6hdVGzrcQqGSaMLYl2frXXqwxbTddKZbytg+1EJVbmLoCCmUOHzMMDvMeq5h0hkNANes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tH9j27wM; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727946919; x=1728551719; i=markus.elfring@web.de;
	bh=QfbQUxKe0kMlzpB+5J+6ovEC3y8cAE+iV9PdhEGYHZI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tH9j27wMd94YY1ZnP8ZhakZ8+E4QEQUopKc3En9IPnhq5xlEKvWEPFS/828Nush1
	 MtSO9VZyhBkiAnPMft+GByzQ1V2k8JBrqEktBOD4Oalg6cuq7TzwoHP3bh/9zmkwh
	 xwWczehYSbHc+pQTaBaJtMIwwlnANHd8fnmQQZHDrt/vmVDFLS6kQ40ipJXsj8Cc3
	 v8/nNb1SYJ1qRTQS4/reahadcVtluA018RFyEomRjMKhEOjmi1p4Ga4xCvcVYlWus
	 SSIjuV+qdweYmKMDXsGqfGF4YXuzfbad8ccDnvgjA93myY4fYBSqHvFk2PQ/UThIY
	 7DBafCBWgMtriCiqqQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxHUC-1ryzDL31OS-00zDWa; Thu, 03
 Oct 2024 11:15:19 +0200
Message-ID: <0f103384-376c-41f0-a35c-8ad98327d6cb@web.de>
Date: Thu, 3 Oct 2024 11:15:18 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] PM / devfreq: event: Call of_node_put() only once in
 devfreq_event_get_edev_by_phandle()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8uzWcBcb8tBnnghI0zA3+tXn8pmj4OiNVjA4c/rNoXb/vlp797P
 1M0zU39GleC8AevZ+HLCvvP5QW2kP5YUg08WADNDWX6IUezn6gGOIbGH6P+6D4T5OSfSrCu
 uolAGO7JLWYS3o/9Z8smRnm6qxphQ6Ge4uAGc73TVkwHSsEYWlkWYwwUUF5cBtPuw9YnR6t
 1Qc+eid5V+OXz7GLN/lbg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PhU3V0Zhrj4=;RzUjTWaD3GzZ+1G0MzL9bbw/kAg
 bS/jUIG6BXH4vAt33629r4RwW3VdgKtHTdDds/eDOxynvtZ4I22KDOeaHQ+3sxlbZqEvt5LpY
 E3GKBwPOFEd//OFhPsXDO1/oaWLuScjaxhzVxa91ULf/vdsMPYHT4gUrDIxTvJm2xsAbk8IK3
 pFSWLN9j9CSkRdPwu0mTsZiAG+aiQUd10DJLEGC2yWhKPJExPK5XJP6IcmWrxhHwjSqWXgvB0
 wr3Av9TWnVihOIazlRuvRQoOZXS0tR23JONtbMInv8Kd4XXRdS9q3/QsiFUAbbRdOs7VDtGWi
 q0Ce+xLEMo6lXnJmRZi49lH9d6VZtB29bssQBaAA/WAQGa8XuTY3A7OFUFA2ArWkfv/6hFsmk
 0Ww0D2HHiLla/hSFl2D6+jpHu3wwGR3HK7Qz1OqQJBdp/MlOngz0pBY4o5313B6FZZNsf7r+i
 ZzRLAdqi5I/zKq6m1Mx0OBVwXNVHaCnACpCv3MlVRYGLJK4fouQQoKjTLHjIgvlV/QcK5ql4o
 5jTdSlQF/N4Mi6AHdBDZlb2mIXo98RXtIJfkVEM1PCDSGm8sqKStgbH9E4VssXLQcHZA7Y129
 HPKmILTPTXJi77XoS4p7vew4e9qjCUyhMTBUw7Zb1Sks8VZYLgHC8fi9lXA2+j3kqPCjciock
 YzZ1AGEdVA8xrrJs1i2wNCJzHguUUQ8PoywmSmZp41jLYIQvyKASC14yx4hMV+PoJvs226jQj
 e7/RDR+bbx7Phc59XICIlr+DnrjGtelApU/6qNauZVykOn2NozfhYTC+Pn0m7PGde11IachhG
 2o/Jb4W/U2nO3Zq3qaIIsbAA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 3 Oct 2024 11:01:30 +0200

An of_node_put(node) call was immediately used after a null pointer check
for the local variable =E2=80=9Cedev=E2=80=9D at the end of this function =
implementation.
Thus call such a function only once instead directly before the check.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/devfreq/devfreq-event.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-eve=
nt.c
index 3ebac2496679..70219099c604 100644
=2D-- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -244,13 +244,9 @@ struct devfreq_event_dev *devfreq_event_get_edev_by_p=
handle(struct device *dev,
 	edev =3D NULL;
 out:
 	mutex_unlock(&devfreq_event_list_lock);
-
-	if (!edev) {
-		of_node_put(node);
-		return ERR_PTR(-ENODEV);
-	}
-
 	of_node_put(node);
+	if (!edev)
+		return ERR_PTR(-ENODEV);

 	return edev;
 }
=2D-
2.46.1


