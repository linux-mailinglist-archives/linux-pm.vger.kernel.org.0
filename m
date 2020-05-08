Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024571CA97D
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 13:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEHLZ2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 07:25:28 -0400
Received: from mout.web.de ([212.227.15.4]:50547 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgEHLZ2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 May 2020 07:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588937121;
        bh=KRtwDig6jNi/2gGxUoywgUs81u3yGPRZxNkFSLPvqvM=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=OW1SdK+phrRraO6wpjvEB+Qspc7FduqwNpB1mqeASrXFnbxsjUY17Mn58LvaK8syY
         lsq+yLi2NChP5f1osffmk9/I0cv3p9YN60JNCuiFrnnhfoekhULJ4Omtuw07IsMj6t
         wm+VxI/kzsrNwBmxN30X6MkZTqbgFkNEWTiZiBwU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.146.138]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LkhUq-1iwrQq3PgC-00aVT4; Fri, 08
 May 2020 13:25:20 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anton Vorontsov <anton.vorontsov@linaro.org>,
        Milo Kim <milo.kim@ti.com>, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: lp8788: Fix an error handling path in
 lp8788_charger_probe()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org
Message-ID: <ccb359c1-b157-6d41-5fd2-791a368d7cf5@web.de>
Date:   Fri, 8 May 2020 13:25:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:95copn6+sFJb5Hv5dLgrhtuzFCIVzSgoKbKDtuz+a74fYlwYhY1
 shaOC5gMkLUk1hKzqK0RGmuHltZtuDy+xN18foobCmt1EKCE8maDkx2Cm1BjhomTMyespiT
 /PDfD9nuuUyVFXgA7qkmsdIcwavy8wJPRhAZsSELvnNrJ9+SiV6YlSOm88X+1uOEW9fVvl2
 epTqC4Uebe4c7fNSTkfwg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mg3N+Ul5hXE=:H9xGnI8DOclGrzBUbGrVLy
 HwsEz8gE2CeRkwAeqDsQfZgQD89f/6GLuskhjIUDmGD0tkZN6znq9PJ6orEzn6IclEjou4iao
 AdlWAN0HmC44vsFeL76Xnxm3leAXD2Yb1I9eNG/Czz15zDyeZxsLQsQlRVbj3IR5U9QuxhZYM
 5z3CUi8UZ26eKUl5tRtxMxB7D4Llm3Hu+iJUW3JGsGe9Cc0snt/28KnvB93yveV6RXoh3XGq2
 MJ4aPPjmhMZPWb4YIMOsojgIcf83NmPz+9gu5Pg55iitZ8oGX6FmUyBV/UzYjXE2qza5H/hNP
 rhkaVnBtKT4nYo9pISePMZI6iOzjx3l25dLdTql93Kbupel6KtpUTV2Fq7culIgzvTKvH9Pmy
 VoZQ3uuAV+VaT/wK0fXpdzV2RHzisIsn8jAT2CSml2+GGnKpEFu7nIOtRnfw5I+jC3ztyIzQt
 nNWKEUFrHmZ20lmvBCGaMoe2DrLgRkeWggeZJQRnhD5tYaXjxQLNeAr8ADtgrxhn0m/IjIq32
 r5DlXSA6G6kYKMh1iJlYSlIXqSo/CBEeGOYLLqlgfcdtsXL2CVfE3hDT770W6uo/f4nrySpvf
 G91izl/MtJrHAdto2o3TRuODifl9y5Ebhy5DDznD8SfmV4Q65ZI6ZxwKNmx9aDqas2PaFvits
 CJDo2qoG6ntduf/S9+Dbaf7YzDMaaxfUgEH732JHA9i6hhXY3wH3B+RQAW4DVpM9q1oFbQU3k
 bzssYjeIciqKuSBCgegYe0cuICLvYAWwPCB5vdIbsxFlzVcNRNXKlp0RWwN1s1wtf2394Q1ti
 qMtbiKqEnhm4p85+oQYg7PySoTzloom7v24kOgxXKZf7wHPW9QivHcWk/lUFfYbIJLr3vFrjj
 CVtcZrz6tL1AdrF9hnOMwfeeyLVBDYHdPRzc+mbZVn4x76Jz9iZWmF52UGoOcBH0Kdma+Y7rx
 +sosJ097v28UUtsrE+QNpc1k09QkJ0554tVR2vkGKxzfhjDxEuK3KHeZbeeormMno46gNZ284
 t6QEHDqDP7Z8U4bTezgruLdLBnEUDde6F1a8mTZL6Got6PFCqmqdXKWxRzq73L5xya2stQ7Pf
 QjaMR0Y4CEUC18NPH7AbPHvNP42eDYRGom3RWKlSUrjQL/Ps87pq2VZJG0bErXlpeZ0/lIOXw
 ymuTfa/4dbDCAlPGr+UK5KMqPEHsX3WvZ2NB/mFHriLXRdWNiLS1N+/t92lIGKCse+pxddieI
 6UYfrdWO6hjLJfSZX
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> In case of error, resources allocated in 'lp8788_setup_adc_channel()' mu=
st
> be released.
>
> Add a call to 'lp8788_release_adc_channel()' as already done in the remo=
ve
> function.

I suggest to omit apostrophes from this commit message.


=E2=80=A6
> +++ b/drivers/power/supply/lp8788-charger.c
> @@ -719,13 +719,17 @@  static int lp8788_charger_probe(struct platform_d=
evice *pdev)
>
>  	ret =3D lp8788_psy_register(pdev, pchg);
>  	if (ret)
> -		return ret;
> +		goto err_release_adc_channel;
>
>  	ret =3D lp8788_irq_register(pdev, pchg);
=E2=80=A6

You propose to perform another channel release only once for this
function implementation.
Thus I find nicer to specify the desired exception handling in
this if branch directly.

Regards,
Markus
