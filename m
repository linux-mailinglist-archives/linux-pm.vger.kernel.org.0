Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2704B19DA13
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 17:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404225AbgDCP1v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 11:27:51 -0400
Received: from mout.web.de ([212.227.15.4]:47107 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404210AbgDCP1u (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 11:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585927644;
        bh=FZE8XFtHxsSSkLcLbV7ydE5I7Jzg6h3B+G4UytnhkHc=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=sq4dJ/hgyxUuTyOP6GHxCv+r4xLO6gWBf/8WvZPU65mGCw8rFxTbcQpCb9MXzczrV
         eKahMExDuBYHIVQcjBJsNkQ++0ObsN2SgeHnaD5sokHiYar0m2m1DYgdhDFjgAdIBD
         bbJ4jf6nla3JMCZOvX//kNBytXddLmCHW8zXVfqc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.25.116]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LdalO-1itcCM2kjK-00iofc; Fri, 03
 Apr 2020 17:27:24 +0200
Cc:     linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: 88pm860x_battery: Use
 platform_get_irq_optional()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Tang Bin <tangbin@cmss.chinamobile.com>, linux-pm@vger.kernel.org
Message-ID: <543afc2c-d988-f0d7-1cfa-0bb7364c4486@web.de>
Date:   Fri, 3 Apr 2020 17:27:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O3wI8l6crCKhor9aO2R4zboFyjjEmaDEMA7PqZjBCFMQlUTidrY
 laPyyT4FrtFwvCVzZ85jWYtlXfqEngReUkyIfq/DVtmzJolhbfWQ0Xw4l1qEXr8rHwgP5/1
 0VCYfzy4TBwl42yrsBJP7/kNmRi6nszLVhrNdka+lNlmrc0A0Sb4sGiUHH/c1n8muoeFCjh
 R7DRUYA55L054d6w4NhZQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KWLSqVekJio=:lY3OGcSgV4ryGrY2DWKmeB
 uNojPK8QhFSpjqPVU/wFM9SoouD/UXnROlch2dm881e/kD7H/0J6b1iR++uvFIL5jLob+lIFn
 XWlKWS6+SdIifE/RI8/ypkvlQiS3Wnsli2B0KzqS/cChIIdFhmc2y4EbIs5wLVqvvo5yLrwjf
 fqcWdWM3JNS5XZtPsVngBLDcwLEpspQXSfMiJnEu2S3jOH5ALO4uIiyxhSGq9A3B9EYlWzoYj
 JCp3idgDigHcBaon2Lv8hKdm1L/RsGdOjwrGDkfxj3itsQV4G2JRX4bQA+Hs03jgNE16UiUhU
 5D8KV+cji0QNB94bjoUgKgXaEBLgag83YwOhm124xVZ38cTyHztZnNJGndOgerJTXqLwA4h17
 iwOJnh1itZecS4X/zQog/xgXp3Ft6qfWnOENe20vl9Nfoe/n6r2CPTZMbpJnkSfcYcAR+QHDs
 R3XM1g3qZgZIX4FqZkZG2NqdpRgv70iD9UI1VQCp0j4S5Dxh+5hQsDFSHzc8dQae2S5fzc94Z
 Jp4nOeXT4793nTiqKtGIMDx5WqwkVx9BHWRkLttXt5ddqk2YAZWdS37LPWe63MjpykuOMrk/A
 VkjS3EkcwRqRN9EwuKpMIaPsqo5hsc2NCnfgskOYLtLUN+Lhpoze3fOosBe9ML/vy0KAv/Lc+
 IaYh5TH4RKP6WcIJVE3wkX3NSJ4GWBbrj+2cjdW/k+VUiRZBW+BnAccpr4daKNYAiT7NOxKm6
 bXNcHyVmjuikPauQhFJBykninXfTLv/r95hp0g4AL24VgkcUMK1Rj2nT/BDbGe8YpZblIRPKk
 7Cg+RJ5ZLO2deFztn97HvbRIiyTk8mqEvfoFYkmZ7zNA67OU9M0+Q6Mm7pd7acmnwj1s71zkX
 cIMlao45J+dmUpxBZ5Wvpj0yZkmgFNJ42XaQvlpn8nkDYmYc6Vs4Ntf4Ao0ePk3LR11cyf0ds
 XdNkLlRnKSmQbc1gteqQZnk3sT97lu/KtOu8u9VVOFkSd3oVwb9sJEELB/tcIuvw7TovBZs6C
 0Q052bQAccfxnGQs5ad94VqAbwYYJ31eIlye4S+BL03PtQNfSBoQjmgrfJLXPr1nif9RajcZA
 mNDlqFwgP+J5mQjL3B/k8MNYtE4dSr5cLW4F7/iENUPABMUC5h1/StoEEp3JxgRtHCQy79/QK
 qfkTXQjtG36pDCULoochbL2wYgeXgwwvPO+UuAesoqCoO1XkcuGz2Fu8GDeFL95Gh9KL3j77e
 5yOUkW40BXG2H7/kr
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> In order to simply code,

I guess that you would like to simplify the source code a bit.


> because platform_get_irq() already has dev_err() message.

I got the impression that this information does not matter
for the change description if you would really like to call
the function =E2=80=9Cplatform_get_irq_optional=E2=80=9D at two places dir=
ectly.
Will an imperative wording be more appropriate?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3Dbef7b2a7be28638770972ab270=
9adf11d601c11a#n151

Regards,
Markus
