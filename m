Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A47202774
	for <lists+linux-pm@lfdr.de>; Sun, 21 Jun 2020 01:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgFTX5s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Jun 2020 19:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgFTX5r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Jun 2020 19:57:47 -0400
Received: from omr1.cc.vt.edu (omr1.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:c6:2117:b0e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1B4C061794
        for <linux-pm@vger.kernel.org>; Sat, 20 Jun 2020 16:57:47 -0700 (PDT)
Received: from mr1.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 05KH3UHW014354
        for <linux-pm@vger.kernel.org>; Sat, 20 Jun 2020 13:03:30 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 05KH3PUW002611
        for <linux-pm@vger.kernel.org>; Sat, 20 Jun 2020 13:03:30 -0400
Received: by mail-qt1-f199.google.com with SMTP id l1so9668798qtv.13
        for <linux-pm@vger.kernel.org>; Sat, 20 Jun 2020 10:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=cs5+3ih73jFMu6qpNbvhhGPhDRDuHq3E6WeyXknfW4k=;
        b=OdGYUd6sRB3XuY83Zs82fT3aP6TyHMZQpQg1sWVTPKpIf34grA2bzCWnVxgCBCZQYB
         G0ZQkUoFFRX1zfS44GweczLFI9q6AKabg5noLB0lb3oUKlOt7zaQ/7waSmu2G3aLm6Eg
         VgpRN3Lqy2e+r4wsBZjAXCJ6A69EMejEwgw8Z6L030VLQ6GSyfAsIfSpRiXqAKg+Yuad
         Jpboy9EJ+XviEpqpIR4mcaBRBZafahsynjf7Rn9A8mAc7RR1LdYBJRFnnw+K+KpW0Hw1
         KbIMamAKzFoUJ4oECt1xqHMZEsDd8ruuL0dlQMw4kS65ZvBhFYaYelZTq7CAFFExF4lj
         bxKg==
X-Gm-Message-State: AOAM530hBqSlyF0khQ72RldmruYUqbHT1Qt9yHN1BQpIFWeGbVlhAX2O
        4unXjkWlzfZYBxZlfeQzVytaS7ExV635Rl8edIgpd/hygvpfjyOZAg5qp2xHeFmLVk0Fo8BFEZ+
        85hiGAnj7Pd24BjF3WqR6+bUoGB4QVw==
X-Received: by 2002:ac8:6f2f:: with SMTP id i15mr8927049qtv.73.1592672604852;
        Sat, 20 Jun 2020 10:03:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx87DNY6uLlTO0cNDTDy29rsTwxaWggNld5pClSRe8YEiuE4m8qPXq/4gO+YPN+IJzlOzmfIw==
X-Received: by 2002:ac8:6f2f:: with SMTP id i15mr8927021qtv.73.1592672604410;
        Sat, 20 Jun 2020 10:03:24 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id u27sm9708775qkm.121.2020.06.20.10.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 10:03:23 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Sibi Sankar <sibis@codeaurora.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: opp: core: Add missing export to core.c
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1592672602_62491P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sat, 20 Jun 2020 13:03:22 -0400
Message-ID: <566735.1592672602@turing-police>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--==_Exmh_1592672602_62491P
Content-Type: text/plain; charset=us-ascii

After this commit, a 'make allmodconfig' fails due to a missing export.
commit 5f2430fb40c74db85764c8a472ecd6849025dd3f
Author: Sibi Sankar <sibis@codeaurora.org>
Date:   Sat Jun 6 03:03:31 2020 +0530

    cpufreq: qcom: Update the bandwidth levels on frequency change

ERROR: modpost: "dev_pm_opp_adjust_voltage" [drivers/cpufreq/qcom-cpufreq-hw.ko] undefined!

Provide the export.

Fixes: 5f2430fb40c7 ("cpufreq: qcom: Update the bandwidth levels on frequency change")
Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 6937bf45f497..c9336aac74e9 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2302,6 +2302,7 @@ int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
 	dev_pm_opp_put_opp_table(opp_table);
 	return r;
 }
+EXPORT_SYMBOL_GPL(dev_pm_opp_adjust_voltage);

 /**
  * dev_pm_opp_enable() - Enable a specific OPP




--==_Exmh_1592672602_62491P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXu5BWgdmEQWDXROgAQI4Iw//QnU27JvHhCwuSrw8cmYSTiRJ6QqGgJLQ
4f7MpTHE7P8t1dxc6AI2ciIT2gt60f28Yc9nh6PmKiUk8zJ3jCvupor7lUGa5WaU
PQY3PLvgFIvfeRD+BkrhDOleZB4vpWJ7b7Zv7kU66/IyaxebnSY+p9JxVrbdzboY
nkuPh+sYARz+HGnpapOyVKrs5mIchFTPpl+yYjIoae1vq13IieIqJA5reEfIyLeF
cmnt6pXuNdmU4MRkPK0GCaWmePq7N5utrSRTcY6NjbFE5rchLChJrWD1bH2KvOPi
zGPVX8NvdkpVThORmqrO3CJbf9CmCSwOAsjLxFKXQzB/OwbbexgAaEGsv4qkF4ZE
up0u2auRNidb7ZgHN3MWaMVQkLP52xB2EbkpyjAXsVmjknPnho+RJHGiq6q5jTnP
d632L39BjUwh74qNNKtHS5PMBCgpFQoFP+SRRGR3xSZbodrjigVDYxWKRDR5Ue1B
ilOu58VO7+jhm0WYukf8ukA3KpjRMMRpAJ7U/lRE1PmYdekgR2gFwFpOqiweeSpU
oRu/QpQ6O0sARN9T4+SjtYAkhvM4cw6XFr9faZwygi6LbPkgg4krkrSXg3RFWu2j
EQJgc8f1WyNQQOcSbrP+vLPo2N81kcW1nbj3NLP9YCu8KvkzzdLRHpk0MWD9iXds
akVwlJC2Hck=
=QLy8
-----END PGP SIGNATURE-----

--==_Exmh_1592672602_62491P--
