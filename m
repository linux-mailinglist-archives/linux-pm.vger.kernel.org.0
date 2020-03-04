Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D65FA179077
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 13:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgCDMe3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 07:34:29 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36461 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbgCDMe3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 07:34:29 -0500
Received: by mail-ed1-f67.google.com with SMTP id a13so2123920edh.3;
        Wed, 04 Mar 2020 04:34:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L3VdjSXkTyf2Ulpvm4N7Ob3rPnJ0K39EKBP/xv4PbHc=;
        b=IA1zfGPz7S9vIBa7nbtWEQlIGBAG7XL16ciNO5XGdee7eVS08iNXmp2yYYipkoh+xw
         aOvBiBT6exnzk9D/9Q32CWIz6TYB9U1woy9sSVav335Z+6qicMDIWU35OQwsc7G0LOra
         5GvJ8MyCO5nbKXOBPhzlygK8/ZK9/ifgfw/5h/NdllZcZONsmnPRSwtSf3+u6z9csYBl
         Ch8HNp13Zeow46s9C7TZOV9f6Vdu8Xt0SQpEPaI2joEV0554o385PLVPL31XudYbeFru
         tAjFToEUZmvOdEPQCGJvGzDAq+tAiXA1NLWFUMfTBFxpuSaxGvjCPzb4D9dZSbAtEepv
         U7ZA==
X-Gm-Message-State: ANhLgQ24P4PgJwf5UIlfYDw0dNimYg+2jdhmHijgp+K0JQ2ot1KVViaS
        gYVGk6Q7A+C0utsHZKDwjTENwe9I7hY=
X-Google-Smtp-Source: ADFU+vv50mDo4l3Kc0rYdycGnAtW+wggeAzaet+CMAL47vcSbiWYE6Wq57QEBV4BSDPVpy+lmocZJw==
X-Received: by 2002:a17:906:8284:: with SMTP id h4mr2223306ejx.224.1583325266504;
        Wed, 04 Mar 2020 04:34:26 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id ss15sm1193132ejb.10.2020.03.04.04.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 04:34:26 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id x7so2215380wrr.0;
        Wed, 04 Mar 2020 04:34:25 -0800 (PST)
X-Received: by 2002:adf:9c93:: with SMTP id d19mr4101231wre.64.1583325265577;
 Wed, 04 Mar 2020 04:34:25 -0800 (PST)
MIME-Version: 1.0
References: <20200304113452.10201-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20200304113452.10201-1-lukas.bulwahn@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 4 Mar 2020 20:34:14 +0800
X-Gmail-Original-Message-ID: <CAGb2v66sJ42yaLwHubrOvCNBQQ4sJ1HXYpVmf86oW-sp7bCqGA@mail.gmail.com>
Message-ID: <CAGb2v66sJ42yaLwHubrOvCNBQQ4sJ1HXYpVmf86oW-sp7bCqGA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update ALLWINNER CPUFREQ DRIVER entry
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 4, 2020 at 7:35 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit b30d8cf5e171 ("dt-bindings: opp: Convert Allwinner H6 OPP to a
> schema") converted in Documentation/devicetree/bindings/opp/ the file
> sun50i-nvmem-cpufreq.txt to allwinner,sun50i-h6-operating-points.yaml.
>
> Since then, ./scripts/get_maintainer.pl --self-test complains:
>
>   warning: no file matches \
>   F: Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
>
> Adjust the file pattern and while at it, add the two maintainers mentioned
> in the yaml file to the ALLWINNER CPUFREQ DRIVER entry.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Maxime, Chen-Yu, Yangtao, please ack.
> Rob, please pick this patch.
>
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6158a143a13e..8e5ed8737966 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -691,9 +691,11 @@ F: drivers/staging/media/allegro-dvt/
>
>  ALLWINNER CPUFREQ DRIVER
>  M:     Yangtao Li <tiny.windzz@gmail.com>
> +M:     Chen-Yu Tsai <wens@csie.org>
> +M:     Maxime Ripard <mripard@kernel.org>

There's no need to add us. The Allwinner entry already covers this under sun*i.

ChenYu

>  L:     linux-pm@vger.kernel.org
>  S:     Maintained
> -F:     Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
> +F:     Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
>  F:     drivers/cpufreq/sun50i-cpufreq-nvmem.c
>
>  ALLWINNER CRYPTO DRIVERS
> --
> 2.17.1
>
