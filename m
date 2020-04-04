Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBD219E72B
	for <lists+linux-pm@lfdr.de>; Sat,  4 Apr 2020 20:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgDDSp4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Apr 2020 14:45:56 -0400
Received: from mout.web.de ([212.227.17.11]:42253 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgDDSpz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 4 Apr 2020 14:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586025938;
        bh=1cv7GZMRsxz/iQJWYDwvY7I9F4CuXN5gGyZqWSBpVTo=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=OyhynnDm+sI4j59e+C8JOGchNBvbqGkTf4/AneKjrcbcoxRlFRCt5BXGR+XoFM38c
         qU3NJrVRhnlXJuDwtYoTlJS1cy9txsdzvzhsLgFRkB8ksK71trhktqRra01AT9yYRv
         Nkq6fC8p8VqsJ+iN8XNl0IcY9AnEop0laYXPsACI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.181.229]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9ojk-1jRRe61hQu-00B1ph; Sat, 04
 Apr 2020 20:45:38 +0200
To:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] PM / devfreq: tegra30: Delete an error message in
 tegra_devfreq_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <ba67e238-43a7-6c53-363e-7a2c12f09949@web.de>
Date:   Sat, 4 Apr 2020 20:45:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+RzL0jC8GHo98AKqDvL7PkpfFDCleYAHzx3/9kMfe8iXhd+Dq9c
 1jrSN0wymTqkp+U7ay+GeW+UBWOAzkOtCeJdAyzmt6JaZ1rAxqLA8fZreqp2XjZfXixhD61
 PZ28nYrrUxbB5suzB2Uf3pAg5YMFnCjNovnQLc6WAqK2VsaH609A9MhkFlZdotUnGwV2H7U
 5nmOasHNlos2kkED1jpkg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VGiNLo6JLfU=:rTb6F7LBf8Nc5+Hnx1hWbq
 uKB35VAJVPLB8nNBtBvngglmi17zfB+34jQHvSUdFDF7vM0wxoBr9ES7OFzapj27ytJwnhC/o
 1rmfFBkv87swXajajsEW26uCrrkNd2L3+yJrF2IwFrwhoa224qsSXeOJI/HqBS+Y0BkMlpJP5
 wFgOiuGhAWHCHkp2f6fg8F6DxoL0b/dDHhJED7m86YidWK86EZJ0MwHpqaix/+MGFZr8nC27X
 0rp93sKFjfTQ9NDizL1SFXYaaHonoCZcpckxwBVmiTdko2u2RaTuxBMLUd4OTwPzeh92ZuKNc
 +h3/y3B6q27TbtSMASGnK0yM/jI3YBubjQYuonysXk7KB6Xv6wWJC2GindWCcyVB6U/KBqobL
 t1Pvh0C9sfmSM78yonru5tmWH80t6SOwer8PK0kJaTZvGuydRmhbInRpfZArO7b2Io7LUJUYn
 rpkFO319g0MndzlhXBao/dwLEO9WLvrwUnr2ognuDWxnyCDR90mrSWje90EWWD7D24L2yoFlk
 Eh4z4f9yhXS9a/KIBSAajjyv+ytlSkZOFddwFGGqTu+blWj62lYddqMr+QkksnEyee89kYNTJ
 d3UNo9glb0M57SUCrzbzW65gjF380Wl71n54Iu+Q/EpKomjuDiuv6U5lVB07KOAgotaAPVKRC
 EvgRzEZH88+6przX1Gq/6aSPp3UUH4Kfol1jDIQDv81cDc+APGuwSANXgE70RaEwWamVQe6Wd
 4Z7nNfWAlIGPvxrNPUGDzBvykiW6bsEFia0MAGZk1blrAhvDedU5DQRdsMVqrDG8Dt343ZN9n
 LaZiO2/CV2U7lNMgHRZxm5o2PRjnO6taeQzB1sRvV/HZtSXtuV6QYXCCKy1PZcnh7M7/x8AGh
 hMhzaYSYY4/nn2GaB4R26xF7azWhpgreqM8rgq8UDioW61aYKoPgXTHZQf/8tBUyjLEyVQtUb
 ghPSkEsEATtkEZsFkM0RI9P3jDnqRwBzeUrn8vYA49ekP6lpfpTwri6SqOOHPcX7/GIB/aqcJ
 /ww7HmZr+NxxmOARh/a69QKgTiHCGVF/LAnojGiy23DzP8b/HKgaP7sry5xlmEwwuZbvTLgV9
 RgaadQZUx0q0HRWjhCJEDzvMqJcHt2k3/EjmMSkqXFWNW4Bl7JfpsEVszlUco06NT2uOMqc3m
 vUU7ExyCvdLmlBripTvJoC+l6Q4LGoW/WLk1xCR+Lyx/wiC+KHgPyKkDSRLHiLhRGrPms6TP/
 4857SU6KWQG+s3YYv
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 4 Apr 2020 20:34:02 +0200

The function =E2=80=9Cplatform_get_irq=E2=80=9D can log an error already.
Thus omit a redundant message for the exception handling in the
calling function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/devfreq/tegra30-devfreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-d=
evfreq.c
index 28b2c7ca416e..93e6f4b25b04 100644
=2D-- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -807,10 +807,9 @@ static int tegra_devfreq_probe(struct platform_device=
 *pdev)
 	}

 	err =3D platform_get_irq(pdev, 0);
-	if (err < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
+	if (err < 0)
 		return err;
-	}
+
 	tegra->irq =3D err;

 	irq_set_status_flags(tegra->irq, IRQ_NOAUTOEN);
=2D-
2.26.0

