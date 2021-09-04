Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985E4400BDB
	for <lists+linux-pm@lfdr.de>; Sat,  4 Sep 2021 17:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbhIDPRx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Sep 2021 11:17:53 -0400
Received: from mout.gmx.net ([212.227.15.18]:43507 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230514AbhIDPRw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 4 Sep 2021 11:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630768607;
        bh=4ANx2vQH7iUfBjxYEEyIv5InnOcmLlsv7CD1nz2q4jY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=M2cVjhoh45xX65ta5m4cPtHvdxIPNrpAw1F0G0T1K8Bkjrsb1r737tvEy/imRgV9V
         R6XY+xNsY6tXNuBrjGwznpZEzzcH0OBexs8PNzLRILuYsXXU7jqJSOjAqwCrbD1v//
         2q38xp61Cit8nzz/J/uLO6o6up8N1npRmQodOFn4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MEm2D-1mAl2S1mZ9-00GLJd; Sat, 04 Sep 2021 17:16:47 +0200
From:   Len Baker <len.baker@gmx.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: powernow: Prefer kcalloc over open coded arithmetic
Date:   Sat,  4 Sep 2021 17:16:28 +0200
Message-Id: <20210904151628.6618-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fz00f2zl30lePk2hUfI0+vrZgaY3Bl3Wi4wOgZXuYJcsYXGB9a/
 1HzQ7AE+uqZMFjtXiuz2uMNtCDKrspCycA1Nrp7Ov+I1k9mtyYnwE9uj6itUvA9IiDWVtgs
 bjTIqlJk9vDugJ0j9CWus9+Z4u0/te2pNQ0egxgxQ8irvntBuCSAigmw4NB01DVaDFxTHrT
 UWcbj/wFyHXSf6uSpKjLw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qTf5c/4A6Rs=:xfdaGwvgcm9LZ29ZKYCxNt
 6S/WTVipfUO/io6x8Tq29NiZpqNd+/6lhkfV0+xqa001fNV3Xl6A8iq3If/kGmBLigatlqEc+
 z9NVFjzq9SMhK4v+/gqG8OhTf1LJs2+WSKUzze9T3nofcR1269nhNc0AXZgtn8sYQOMGjblRP
 cEbiXHr0sAMsamAGcy34/Fu3KI6J9brHdi3irt1fQQ21onQOSfi1urB/x080B3nVgl+KR/NGE
 5A/G0hg2aHFfi+DB/6v64GkDTHiaaGyWFDyv2+xU76wnlisuGUB7DCOUgIMEyO0Ic0r+gPJek
 7yTIg1vWGwMlkCHOpIksljYTQuefmgqGzAXNrcpYccLPZhqQ6m40ntq12VCd1S3dtKpWJlbL5
 0U9r6LGqoFlH4qTanV42DVi2BB57P6CrdHgWtPCBtycz08NE0Eld7vSq3cVrZcfAN3hZGXHt9
 WFmAzaGupy7Ea1KxF8br2C38UcK1oh6lcufd5M9WMADGavj1ZUQnsv/BpF1ayvf3ktBKqHCRf
 h9YiAK6e21BhOAUk71pjoBgc14wEhkYst1JonYfkC/7puEHmIcTSdg1iTbv750crQEftt6DHl
 43ELQjQ2GJ+q47t46zGamiM+PIVV9oiHSQwqt8hKFM2q42bpMVztI9cHorgpLq4VCsoR7sFjc
 UKO5reKsD8vYXr836IKc3xDJQTIHsWFCZKNpU/A9bE1PImGqMVAjsJ3AhRB2fPj5Atd2M7oEJ
 aLmXTKlpLT5kVM79jxHyF5WH3w50CjPRFoG1WtSXJ13RzQrCK6a44Pk8tr2mDUkipnlEpnwu6
 o6/vE25vsHkbrf29ilNPstZaNA+VBZQ+gK7rDBUEMJPAmVGIiIs19ZsIxySrf8BhgS9jmxTCh
 zgrkLQ6Xfs4vaFXHs9XxABrDk/fCaiqvS6/ZCceRWYpwjGYv8SoAAlwluRW9gphnNbd8igZ1p
 lu8ComueqEsShBXy2M3hXMRV+2V69mYVR2Ukccac6Twp/9DU/Oydi3L9fyc9LGyNCInk4LNZW
 OKnxiHIl0qre4lwAKriSZg5XcrCqiQfVz23RwbutbSU3MtRW1CGJHbb+pZ6NaW+M0NPIUYiO6
 o5OGeD8vq/w/42ppotMsmCjofADggVaPlEsqj9rPrsDJHgexkyd5LXuAg==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, use the purpose specific kcalloc() function instead of the argument
size * count in the kzalloc() function.

[1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-cod=
ed-arithmetic-in-allocator-arguments

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/cpufreq/powernow-k7.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
index 5d515fc34836..a9d2c7bae235 100644
=2D-- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -174,8 +174,8 @@ static int get_ranges(unsigned char *pst)
 	unsigned int speed;
 	u8 fid, vid;

-	powernow_table =3D kzalloc((sizeof(*powernow_table) *
-				(number_scales + 1)), GFP_KERNEL);
+	powernow_table =3D kcalloc(number_scales + 1, sizeof(*powernow_table),
+				 GFP_KERNEL);
 	if (!powernow_table)
 		return -ENOMEM;

=2D-
2.25.1

