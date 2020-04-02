Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28F7319CD2F
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 00:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388961AbgDBW6A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 18:58:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35427 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388709AbgDBW6A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2020 18:58:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id i19so5660653wmb.0;
        Thu, 02 Apr 2020 15:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=opPFBO0IU0Az+Xk9TafOk4+eNZWXcHlIkMCHTBdtIi8=;
        b=itSzzUHtAj0K0ugbSSx/NLdTyBWHe7sIpUfSEyIbhJTA02pmI//Qh3cDSk5bg5GTIK
         p7TYulVUAq2rgTKePFX3yyTLM+xai9VPMc3n/RVuacJVf0ghHRCOSfnawKvN6vheF4TJ
         VsgAoQmR4F3c9wyVyOUkBgp8fEfLcGawiZTexLWzNjR+pIKFDkfExj8AObbf+SH6lO/u
         VdXTHtdPyHswDXRQg60ngc9kg+b2EhX/Dbx6lvs+rrG9T75uoNqIS/6jgJ+bzwCb9kNm
         qHXvK3CcgtnJEE9EFsEclkWlIkzAAzUhZ7qWJZ4tfgaKQv95DprhRqSZPynZFIIp5OFW
         SBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=opPFBO0IU0Az+Xk9TafOk4+eNZWXcHlIkMCHTBdtIi8=;
        b=oeDT7gDB4jijm4zLTv89/jDPBaBj5yt5WZ9ortsDgC9AiTs75ZkgAnTpHNryaqzfHL
         BNPmayGS8qXNMRbqitp4EDR+SXbeAjOdOZtTFwUb+x+bWkAmJY3heQqbj9vvgOZs9I1A
         6H59T3R/kSG2r/h4ARd+XcwTQcsSZUeTokBlEl+SXmTBY65u553Vs1Is1iiWisUOJ0tJ
         F1PdT8QiwbmQ+unEAkTHwE8AJPvnhSlskfGYmSfvhvJdXNVXp+RL6SgJESSSsvNE3PWc
         be401N213s4/Hwrqydguz+J+Zv+sksIx5TFfLSMMURm9f2fqJpAv6W6UWmnze3PqVuIV
         3hsQ==
X-Gm-Message-State: AGi0PubiOdFfu4b8uC/9139/EEen8JuyzQfIiJCIZteVzSitWGrc9vUs
        2j4VZavGKwgpnYnbkPb0hKE=
X-Google-Smtp-Source: APiQypKPnSyqsoyfdAwXtyZpaY28hg3Mw5dUkka7ZbDaNYhub6p8mRd2eymiVO4t45bgrlYlMVJn4g==
X-Received: by 2002:a1c:cc0a:: with SMTP id h10mr5325631wmb.127.1585868275622;
        Thu, 02 Apr 2020 15:57:55 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.243])
        by smtp.gmail.com with ESMTPSA id s127sm9017706wmf.28.2020.04.02.15.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 15:57:54 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: mediatek: prepare to add support for other
 platforms
To:     Henry Yen <henry.yen@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Steven Liu <steven.liu@mediatek.com>,
        Michael Kao <michael.kao@mediatek.com>
References: <1584611693-3553-1-git-send-email-henry.yen@mediatek.com>
 <1584611693-3553-2-git-send-email-henry.yen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFP1zgUBEAC21D6hk7//0kOmsUrE3eZ55kjc9DmFPKIz6l4NggqwQjBNRHIMh04BbCMY
 fL3eT7ZsYV5nur7zctmJ+vbszoOASXUpfq8M+S5hU2w7sBaVk5rpH9yW8CUWz2+ZpQXPJcFa
 OhLZuSKB1F5JcvLbETRjNzNU7B3TdS2+zkgQQdEyt7Ij2HXGLJ2w+yG2GuR9/iyCJRf10Okq
 gTh//XESJZ8S6KlOWbLXRE+yfkKDXQx2Jr1XuVvM3zPqH5FMg8reRVFsQ+vI0b+OlyekT/Xe
 0Hwvqkev95GG6x7yseJwI+2ydDH6M5O7fPKFW5mzAdDE2g/K9B4e2tYK6/rA7Fq4cqiAw1+u
 EgO44+eFgv082xtBez5WNkGn18vtw0LW3ESmKh19u6kEGoi0WZwslCNaGFrS4M7OH+aOJeqK
 fx5dIv2CEbxc6xnHY7dwkcHikTA4QdbdFeUSuj4YhIZ+0QlDVtS1QEXyvZbZky7ur9rHkZvP
 ZqlUsLJ2nOqsmahMTIQ8Mgx9SLEShWqD4kOF4zNfPJsgEMB49KbS2o9jxbGB+JKupjNddfxZ
 HlH1KF8QwCMZEYaTNogrVazuEJzx6JdRpR3sFda/0x5qjTadwIW6Cl9tkqe2h391dOGX1eOA
 1ntn9O/39KqSrWNGvm+1raHK+Ev1yPtn0Wxn+0oy1tl67TxUjQARAQABtClNYXR0aGlhcyBC
 cnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPokCUgQTAQIAPAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AWIQTmuZIYwPLDJRwsOhfZFAuyVhMC8QUCWt3scQIZAQAKCRDZFAuy
 VhMC8WzRD/4onkC+gCxG+dvui5SXCJ7bGLCu0xVtiGC673Kz5Aq3heITsERHBV0BqqctOEBy
 ZozQQe2Hindu9lasOmwfH8+vfTK+2teCgWesoE3g3XKbrOCB4RSrQmXGC3JYx6rcvMlLV/Ch
 YMRR3qv04BOchnjkGtvm9aZWH52/6XfChyh7XYndTe5F2bqeTjt+kF/ql+xMc4E6pniqIfkv
 c0wsH4CkBHqoZl9w5e/b9MspTqsU9NszTEOFhy7p2CYw6JEa/vmzR6YDzGs8AihieIXDOfpT
 DUr0YUlDrwDSrlm/2MjNIPTmSGHH94ScOqu/XmGW/0q1iar/Yr0leomUOeeEzCqQtunqShtE
 4Mn2uEixFL+9jiVtMjujr6mphznwpEqObPCZ3IcWqOFEz77rSL+oqFiEA03A2WBDlMm++Sve
 9jpkJBLosJRhAYmQ6ey6MFO6Krylw1LXcq5z1XQQavtFRgZoruHZ3XlhT5wcfLJtAqrtfCe0
 aQ0kJW+4zj9/So0uxJDAtGuOpDYnmK26dgFN0tAhVuNInEVhtErtLJHeJzFKJzNyQ4GlCaLw
 jKcwWcqDJcrx9R7LsCu4l2XpKiyxY6fO4O8DnSleVll9NPfAZFZvf8AIy3EQ8BokUsiuUYHz
 wUo6pclk55PZRaAsHDX/fNr24uC6Eh5oNQ+v4Pax/gtyybkCDQRd1TkHARAAt1BBpmaH+0o+
 deSyJotkrpzZZkbSs5ygBniCUGQqXpWqgrc7Uo/qtxOFL91uOsdX1/vsnJO9FyUv3ZNI2Thw
 NVGCTvCP9E6u4gSSuxEfVyVThCSPvRJHCG2rC+EMAOUMpxokcX9M2b7bBEbcSjeP/E4KTa39
 q+JJSeWliaghUfMXXdimT/uxpP5Aa2/D/vcUUGHLelf9TyihHyBohdyNzeEF3v9rq7kdqamZ
 Ihb+WYrDio/SzqTd1g+wnPJbnu45zkoQrYtBu58n7u8oo+pUummOuTR2b6dcsiB9zJaiVRIg
 OqL8p3K2fnE8Ewwn6IKHnLTyx5T/r2Z0ikyOeijDumZ0VOPPLTnwmb780Nym3LW1OUMieKtn
 I3v5GzZyS83NontvsiRd4oPGQDRBT39jAyBr8vDRl/3RpLKuwWBFTs1bYMLu0sYarwowOz8+
 Mn+CRFUvRrXxociw5n0P1PgJ7vQey4muCZ4VynH1SeVb3KZ59zcQHksKtpzz2OKhtX8FCeVO
 mHW9u4x8s/oUVMZCXEq9QrmVhdIvJnBCqq+1bh5UC2Rfjm/vLHwt5hes0HDstbCzLyiA0LTI
 ADdP77RN2OJbzBkCuWE21YCTLtc8kTQlP+G8m23K5w8k2jleCSKumprCr/5qPyNlkie1HC4E
 GEAfdfN+uLsFw6qPzSAsmukAEQEAAYkEbAQYAQgAIBYhBOa5khjA8sMlHCw6F9kUC7JWEwLx
 BQJd1TkHAhsCAkAJENkUC7JWEwLxwXQgBBkBCAAdFiEEUdvKHhzqrUYPB/u8L21+TfbCqH4F
 Al3VOQcACgkQL21+TfbCqH79RRAAtlb6oAL9y8JM5R1T3v02THFip8OMh7YvEJCnezle9Apq
 C6Vx26RSQjBV1JwSBv6BpgDBNXarTGCPXcre6KGfX8u1r6hnXAHZNHP7bFGJQiBv5RqGFf45
 OhOhbjXCyHc0jrnNjY4M2jTkUC+KIuOzasvggU975nolC8MiaBqfgMB2ab5W+xEiTcNCOg3+
 1SRs5/ZkQ0iyyba2FihSeSw3jTUjPsJBF15xndexoc9jpi0RKuvPiJ191Xa3pzNntIxpsxqc
 ZkS1HSqPI63/urNezeSejBzW0Xz2Bi/b/5R9Hpxp1AEC3OzabOBATY/1Bmh2eAVK3xpN2Fe1
 Zj7HrTgmzBmSefMcSXN0oKQWEI5tHtBbw5XUj0Nw4hMhUtiMfE2HAqcaozsL34sEzi3eethZ
 IvKnIOTmllsDFMbOBa8oUSoaNg7GzkWSKJ59a9qPJkoj/hJqqeyEXF+WTCUv6FcA8BtBJmVf
 FppFzLFM/QzF5fgDZmfjc9czjRJHAGHRMMnQlW88iWamjYVye57srNq9pUql6A4lITF7w00B
 5PXINFk0lMcNUdkWipu24H6rJhOO6xSP4n6OrCCcGsXsAR5oH3d4TzA9iPYrmfXAXD+hTp82
 s+7cEbTsCJ9MMq09/GTCeroTQiqkp50UaR0AvhuPdfjJwVYZfmMS1+5IXA/KY6DbGBAAs5ti
 AK0ieoZlCv/YxOSMCz10EQWMymD2gghjxojf4iwB2MbGp8UN4+++oKLHz+2j+IL08rd2ioFN
 YCJBFDVoDRpF/UnrQ8LsH55UZBHuu5XyMkdJzMaHRVQc1rzfluqx+0a/CQ6Cb2q7J2d45nYx
 8jMSCsGj1/iU/bKjMBtuh91hsbdWCxMRW0JnGXxcEUklbhA5uGj3W4VYCfTQxwK6JiVt7JYp
 bX7JdRKIyq3iMDcsTXi7dhhwqsttQRwbBci0UdFGAG4jT5p6u65MMDVTXEgYfZy0674P06qf
 uSyff73ivwvLR025akzJui8MLU23rWRywXOyTINz8nsPFT4ZSGT1hr5VnIBs/esk/2yFmVoc
 FAxs1aBO29iHmjJ8D84EJvOcKfh9RKeW8yeBNKXHrcOV4MbMOts9+vpJgBFDnJeLFQPtTHuI
 kQXT4+yLDvwOVAW9MPLfcHlczq/A/nhGVaG+RKWDfJWNSu/mbhqUQt4J+RFpfx1gmL3yV8NN
 7JXABPi5M97PeKdx6qc/c1o3oEHH8iBkWZIYMS9fd6rtAqV3+KH5Ors7tQVtwUIDYEvttmeO
 ifvpW6U/4au4zBYfvvXagbyXJhG9mZvz+jN1cr0/G2ZC93IbjFFwUmHtXS4ttQ4pbrX6fjTe
 lq5vmROjiWirpZGm+WA3Vx9QRjqfMdS5Ag0EXdU5SAEQAJu/Jk58uOB8HSGDSuGUB+lOacXC
 bVOOSywZkq+Ayv+3q/XIabyeaYMwhriNuXHjUxIORQoWHIHzTCqsAgHpJFfSHoM4ulCuOPFt
 XjqfEHkA0urB6S0jnvJ6ev875lL4Yi6JJO7WQYRs/l7OakJiT13GoOwDIn7hHH/PGUqQoZlA
 d1n5SVdg6cRd7EqJ+RMNoud7ply6nUSCRMNWbNqbgyWjKsD98CMjHa33SB9WQQSQyFlf+dz+
 dpirWENCoY3vvwKJaSpfeqKYuqPVSxnqpKXqqyjNnG9W46OWZp+JV5ejbyUR/2U+vMwbTilL
 cIUpTgdmxPCA6J0GQjmKNsNKKYgIMn6W4o/LoiO7IgROm1sdn0KbJouCa2QZoQ0+p/7mJXhl
 tA0XGZhNlI3npD1lLpjdd42lWboU4VeuUp4VNOXIWU/L1NZwEwMIqzFXl4HmRi8MYbHHbpN5
 zW+VUrFfeRDPyjrYpax+vWS+l658PPH+sWmhj3VclIoAU1nP33FrsNfp5BiQzao30rwe4ntd
 eEdPENvGmLfCwiUV2DNVrmJaE3CIUUl1KIRoB5oe7rJeOvf0WuQhWjIU98glXIrh3WYd7vsf
 jtbEXDoWhVtwZMShMvp7ccPCe2c4YBToIthxpDhoDPUdNwOssHNLD8G4JIBexwi4q7IT9lP6
 sVstwvA5ABEBAAGJAjYEGAEIACAWIQTmuZIYwPLDJRwsOhfZFAuyVhMC8QUCXdU5SAIbDAAK
 CRDZFAuyVhMC8bXXD/4xyfbyPGnRYtR0KFlCgkG2XWeWSR2shSiM1PZGRPxR888zA2WBYHAk
 7NpJlFchpaErV6WdFrXQjDAd9YwaEHucfS7SAhxIqdIqzV5vNFrMjwhB1N8MfdUJDpgyX7Zu
 k/Phd5aoZXNwsCRqaD2OwFZXr81zSXwE2UdPmIfTYTjeVsOAI7GZ7akCsRPK64ni0XfoXue2
 XUSrUUTRimTkuMHrTYaHY3544a+GduQQLLA+avseLmjvKHxsU4zna0p0Yb4czwoJj+wSkVGQ
 NMDbxcY26CMPK204jhRm9RG687qq6691hbiuAtWABeAsl1AS+mdS7aP/4uOM4kFCvXYgIHxP
 /BoVz9CZTMEVAZVzbRKyYCLUf1wLhcHzugTiONz9fWMBLLskKvq7m1tlr61mNgY9nVwwClMU
 uE7i1H9r/2/UXLd+pY82zcXhFrfmKuCDmOkB5xPsOMVQJH8I0/lbqfLAqfsxSb/X1VKaP243
 jzi+DzD9cvj2K6eD5j5kcKJJQactXqfJvF1Eb+OnxlB1BCLE8D1rNkPO5O742Mq3MgDmq19l
 +abzEL6QDAAxn9md8KwrA3RtucNh87cHlDXfUBKa7SRvBjTczDg+HEPNk2u3hrz1j3l2rliQ
 y1UfYx7Vk/TrdwUIJgKS8QAr8Lw9WuvY2hSqL9vEjx8VAkPWNWPwrQ==
Message-ID: <f37d2559-b7ab-9f90-6908-1cd7064deadb@gmail.com>
Date:   Fri, 3 Apr 2020 00:57:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1584611693-3553-2-git-send-email-henry.yen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 19/03/2020 10:54, Henry Yen wrote:
> It is known that Mediatek owns two thermal system, which differs
> in the way of reading calibration data and converting temperature.
> MT8173, MT2701, MT2712 and MT8183 belongs to version 1 thermal
> system, and MT7622 belongs to version 2 thermal system.
> For platform compatibility, we add two sensor ops (extract and
> convert) to the thermal data structure. Each platform will register
> the sensor ops to the proper function implementation according to
> its version.
> 
> Signed-off-by: Henry Yen <henry.yen@mediatek.com>
> ---
>  drivers/thermal/mtk_thermal.c | 148 +++++++++++++++++++++-------------
>  1 file changed, 93 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 76e30603d4d5..13e17c31ba3b 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -120,18 +120,18 @@
>   * MT2701 has 3 sensors and needs 3 VTS calibration data.
>   * MT2712 has 4 sensors and needs 4 VTS calibration data.
>   */
> -#define CALIB_BUF0_VALID		BIT(0)
> -#define CALIB_BUF1_ADC_GE(x)		(((x) >> 22) & 0x3ff)
> -#define CALIB_BUF0_VTS_TS1(x)		(((x) >> 17) & 0x1ff)
> -#define CALIB_BUF0_VTS_TS2(x)		(((x) >> 8) & 0x1ff)
> -#define CALIB_BUF1_VTS_TS3(x)		(((x) >> 0) & 0x1ff)
> -#define CALIB_BUF2_VTS_TS4(x)		(((x) >> 23) & 0x1ff)
> -#define CALIB_BUF2_VTS_TS5(x)		(((x) >> 5) & 0x1ff)
> -#define CALIB_BUF2_VTS_TSABB(x)		(((x) >> 14) & 0x1ff)
> -#define CALIB_BUF0_DEGC_CALI(x)		(((x) >> 1) & 0x3f)
> -#define CALIB_BUF0_O_SLOPE(x)		(((x) >> 26) & 0x3f)
> -#define CALIB_BUF0_O_SLOPE_SIGN(x)	(((x) >> 7) & 0x1)
> -#define CALIB_BUF1_ID(x)		(((x) >> 9) & 0x1)
> +#define CALIB_BUF0_VALID_V1		BIT(0)
> +#define CALIB_BUF1_ADC_GE_V1(x)		(((x) >> 22) & 0x3ff)
> +#define CALIB_BUF0_VTS_TS1_V1(x)	(((x) >> 17) & 0x1ff)
> +#define CALIB_BUF0_VTS_TS2_V1(x)	(((x) >> 8) & 0x1ff)
> +#define CALIB_BUF1_VTS_TS3_V1(x)	(((x) >> 0) & 0x1ff)
> +#define CALIB_BUF2_VTS_TS4_V1(x)	(((x) >> 23) & 0x1ff)
> +#define CALIB_BUF2_VTS_TS5_V1(x)	(((x) >> 5) & 0x1ff)
> +#define CALIB_BUF2_VTS_TSABB_V1(x)	(((x) >> 14) & 0x1ff)
> +#define CALIB_BUF0_DEGC_CALI_V1(x)	(((x) >> 1) & 0x3f)
> +#define CALIB_BUF0_O_SLOPE_V1(x)	(((x) >> 26) & 0x3f)
> +#define CALIB_BUF0_O_SLOPE_SIGN_V1(x)	(((x) >> 7) & 0x1)
> +#define CALIB_BUF1_ID_V1(x)		(((x) >> 9) & 0x1)
>  
>  enum {
>  	VTS1,
> @@ -143,6 +143,11 @@ enum {
>  	MAX_NUM_VTS,
>  };
>  
> +enum mtk_thermal_version {
> +	MTK_THERMAL_V1 = 1,
> +	MTK_THERMAL_V2,
> +};
> +
>  /* MT2701 thermal sensors */
>  #define MT2701_TS1	0
>  #define MT2701_TS2	1
> @@ -245,6 +250,9 @@ struct mtk_thermal_data {
>  	const int *controller_offset;
>  	bool need_switch_bank;
>  	struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
> +	enum mtk_thermal_version version;
> +	int (*extract)(struct mtk_thermal *mt, u32 *buf);
> +	int (*convert)(struct mtk_thermal *mt, int sensno, s32 raw);

I wonder if we really

>  };
>  
>  struct mtk_thermal {
> @@ -358,6 +366,9 @@ static const int mt7622_mux_values[MT7622_NUM_SENSORS] = { 0, };
>  static const int mt7622_vts_index[MT7622_NUM_SENSORS] = { VTS1 };
>  static const int mt7622_tc_offset[MT7622_NUM_CONTROLLER] = { 0x0, };
>  
> +static int mtk_thermal_extract_efuse_v1(struct mtk_thermal *mt, u32 *buf);
> +static int raw_to_mcelsius_v1(struct mtk_thermal *mt, int sensno, s32 raw);
> +
>  /*
>   * The MT8173 thermal controller has four banks. Each bank can read up to
>   * four temperature sensors simultaneously. The MT8173 has a total of 5
> @@ -398,6 +409,9 @@ static const struct mtk_thermal_data mt8173_thermal_data = {
>  	.msr = mt8173_msr,
>  	.adcpnp = mt8173_adcpnp,
>  	.sensor_mux_values = mt8173_mux_values,
> +	.version = MTK_THERMAL_V1,
> +	.extract = mtk_thermal_extract_efuse_v1,
> +	.convert = raw_to_mcelsius_v1,
>  };
>  
>  /*
> @@ -428,6 +442,9 @@ static const struct mtk_thermal_data mt2701_thermal_data = {
>  	.msr = mt2701_msr,
>  	.adcpnp = mt2701_adcpnp,
>  	.sensor_mux_values = mt2701_mux_values,
> +	.version = MTK_THERMAL_V1,
> +	.extract = mtk_thermal_extract_efuse_v1,
> +	.convert = raw_to_mcelsius_v1,
>  };
>  
>  /*
> @@ -458,6 +475,9 @@ static const struct mtk_thermal_data mt2712_thermal_data = {
>  	.msr = mt2712_msr,
>  	.adcpnp = mt2712_adcpnp,
>  	.sensor_mux_values = mt2712_mux_values,
> +	.version = MTK_THERMAL_V1,
> +	.extract = mtk_thermal_extract_efuse_v1,
> +	.convert = raw_to_mcelsius_v1,
>  };
>  
>  /*
> @@ -482,6 +502,9 @@ static const struct mtk_thermal_data mt7622_thermal_data = {
>  	.msr = mt7622_msr,
>  	.adcpnp = mt7622_adcpnp,
>  	.sensor_mux_values = mt7622_mux_values,
> +	.version = MTK_THERMAL_V2,
> +	.extract = mtk_thermal_extract_efuse_v1,
> +	.convert = raw_to_mcelsius_v1,

You are just fixing half of mt7622 here.

From my understanding MTK_THERMAL_V2 driver allwasy use extract and convert in
version _v2. So we won't need to add the callbacks but could check in the code
depending on .version which funtion to call.

You patch set has some ordering issues. I think you should in a first patch
rename function to _v1. Then in a second patch add actually add .version and _v2
and fix mt7622. The latter should also have a Fixes tag. Not sure if both
patches as they both together actually fix mt7622 driver.

Regards,
Matthias

>  };
>  
>  /*
> @@ -514,6 +537,9 @@ static const struct mtk_thermal_data mt8183_thermal_data = {
>  	.msr = mt8183_msr,
>  	.adcpnp = mt8183_adcpnp,
>  	.sensor_mux_values = mt8183_mux_values,
> +	.version = MTK_THERMAL_V1,
> +	.extract = mtk_thermal_extract_efuse_v1,
> +	.convert = raw_to_mcelsius_v1,
>  };
>  
>  /**
> @@ -525,7 +551,7 @@ static const struct mtk_thermal_data mt8183_thermal_data = {
>   * This converts the raw ADC value to mcelsius using the SoC specific
>   * calibration constants
>   */
> -static int raw_to_mcelsius(struct mtk_thermal *mt, int sensno, s32 raw)
> +static int raw_to_mcelsius_v1(struct mtk_thermal *mt, int sensno, s32 raw)
>  {
>  	s32 tmp;
>  
> @@ -594,9 +620,9 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>  		raw = readl(mt->thermal_base +
>  			    conf->msr[conf->bank_data[bank->id].sensors[i]]);
>  
> -		temp = raw_to_mcelsius(mt,
> -				       conf->bank_data[bank->id].sensors[i],
> -				       raw);
> +		temp = conf->convert(mt,
> +				     conf->bank_data[bank->id].sensors[i],
> +				     raw);
>  
>  		/*
>  		 * The first read of a sensor often contains very high bogus
> @@ -698,9 +724,11 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>  	writel(auxadc_phys_base + AUXADC_CON1_CLR_V,
>  	       controller_base + TEMP_ADCMUXADDR);
>  
> -	/* AHB address for pnp sensor mux selection */
> -	writel(apmixed_phys_base + APMIXED_SYS_TS_CON1,
> -	       controller_base + TEMP_PNPMUXADDR);
> +	if (mt->conf->version == MTK_THERMAL_V1) {
> +		/* AHB address for pnp sensor mux selection */
> +		writel(apmixed_phys_base + APMIXED_SYS_TS_CON1,
> +		       controller_base + TEMP_PNPMUXADDR);
> +	}
>  
>  	/* AHB value for auxadc enable */
>  	writel(BIT(conf->auxadc_channel), controller_base + TEMP_ADCEN);
> @@ -758,6 +786,51 @@ static u64 of_get_phys_base(struct device_node *np)
>  	return of_translate_address(np, regaddr_p);
>  }
>  
> +static int mtk_thermal_extract_efuse_v1(struct mtk_thermal *mt, u32 *buf)
> +{
> +	int i;
> +
> +	if (!(buf[0] & CALIB_BUF0_VALID_V1))
> +		return -EINVAL;
> +
> +	mt->adc_ge = CALIB_BUF1_ADC_GE_V1(buf[1]);
> +
> +	for (i = 0; i < mt->conf->num_sensors; i++) {
> +		switch (mt->conf->vts_index[i]) {
> +		case VTS1:
> +			mt->vts[VTS1] = CALIB_BUF0_VTS_TS1_V1(buf[0]);
> +			break;
> +		case VTS2:
> +			mt->vts[VTS2] = CALIB_BUF0_VTS_TS2_V1(buf[0]);
> +			break;
> +		case VTS3:
> +			mt->vts[VTS3] = CALIB_BUF1_VTS_TS3_V1(buf[1]);
> +			break;
> +		case VTS4:
> +			mt->vts[VTS4] = CALIB_BUF2_VTS_TS4_V1(buf[2]);
> +			break;
> +		case VTS5:
> +			mt->vts[VTS5] = CALIB_BUF2_VTS_TS5_V1(buf[2]);
> +			break;
> +		case VTSABB:
> +			mt->vts[VTSABB] =
> +				CALIB_BUF2_VTS_TSABB_V1(buf[2]);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	mt->degc_cali = CALIB_BUF0_DEGC_CALI_V1(buf[0]);
> +	if (CALIB_BUF1_ID_V1(buf[1]) &
> +	    CALIB_BUF0_O_SLOPE_SIGN_V1(buf[0]))
> +		mt->o_slope = -CALIB_BUF0_O_SLOPE_V1(buf[0]);
> +	else
> +		mt->o_slope = CALIB_BUF0_O_SLOPE_V1(buf[0]);
> +
> +	return 0;
> +}
> +
>  static int mtk_thermal_get_calibration_data(struct device *dev,
>  					    struct mtk_thermal *mt)
>  {
> @@ -793,43 +866,8 @@ static int mtk_thermal_get_calibration_data(struct device *dev,
>  		goto out;
>  	}
>  
> -	if (buf[0] & CALIB_BUF0_VALID) {
> -		mt->adc_ge = CALIB_BUF1_ADC_GE(buf[1]);
> -
> -		for (i = 0; i < mt->conf->num_sensors; i++) {
> -			switch (mt->conf->vts_index[i]) {
> -			case VTS1:
> -				mt->vts[VTS1] = CALIB_BUF0_VTS_TS1(buf[0]);
> -				break;
> -			case VTS2:
> -				mt->vts[VTS2] = CALIB_BUF0_VTS_TS2(buf[0]);
> -				break;
> -			case VTS3:
> -				mt->vts[VTS3] = CALIB_BUF1_VTS_TS3(buf[1]);
> -				break;
> -			case VTS4:
> -				mt->vts[VTS4] = CALIB_BUF2_VTS_TS4(buf[2]);
> -				break;
> -			case VTS5:
> -				mt->vts[VTS5] = CALIB_BUF2_VTS_TS5(buf[2]);
> -				break;
> -			case VTSABB:
> -				mt->vts[VTSABB] = CALIB_BUF2_VTS_TSABB(buf[2]);
> -				break;
> -			default:
> -				break;
> -			}
> -		}
> -
> -		mt->degc_cali = CALIB_BUF0_DEGC_CALI(buf[0]);
> -		if (CALIB_BUF1_ID(buf[1]) &
> -		    CALIB_BUF0_O_SLOPE_SIGN(buf[0]))
> -			mt->o_slope = -CALIB_BUF0_O_SLOPE(buf[0]);
> -		else
> -			mt->o_slope = CALIB_BUF0_O_SLOPE(buf[0]);
> -	} else {
> +	if (mt->conf->extract(mt, buf))
>  		dev_info(dev, "Device not calibrated, using default calibration values\n");
> -	}
>  
>  out:
>  	kfree(buf);
> 
