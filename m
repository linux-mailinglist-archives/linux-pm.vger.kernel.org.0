Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5725A22CA6
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 09:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbfETHIA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 03:08:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39981 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730690AbfETHIA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2019 03:08:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id g69so6268006plb.7
        for <linux-pm@vger.kernel.org>; Mon, 20 May 2019 00:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sfz/wTK4Fk7TRovLBv1qvhNp3yN3sj59BUUzJlRjkrc=;
        b=lpcM74dz/aZhexCJWtDmJQFV0sKM3IJH8Ic7/gX5171ohRi1znuJy73Hs8hqsJiOlf
         bEhmbUXJU50A5eKZiFhlx0U8A2gMBIVMpcAnR4gMTqoFfqFM4cfK5UJRJbaj2jnuLvnk
         tV37CzvQqnAtGaVudi1HDU2pBtyhI20CF5+iBks9T4IrouY+LnwHeeJDrpAEPbVbsUts
         x4PjJ41O8QELJbc95gQSYbNahprjL4SxeQl9F1FNmyvP119KDWuoHAcSp5qArwK2knbJ
         QW7B2+f7Cppb8V9ZDnf1edb/ogWabtC0is9BkjJHJvNLyT4QPvh30//ZoXP2QFRmyl31
         4KEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sfz/wTK4Fk7TRovLBv1qvhNp3yN3sj59BUUzJlRjkrc=;
        b=k8yYBIi7cMrGIcsgAWmT39cbdHS7m+LzFe58OIuiAFccgh1ywIIhMkuNBLPDElk8Eg
         0ROvKCO/aPKMb0ygwREDmCxcPZFVuchptiCVPPujoLFOM29DGsq0Q5zFcSeSmKU3d6eG
         1lA4Jg3/+nrN9S84H92Z56F8EG7LE8Yq26dn67spCUANJwtls7PgripcU3U2wDjnd3KH
         jJfF9DHlILiOkFFsq+m0w9HdhJsP87xrykDybLegRlDDRa4veKx8JIdm40nwKQBEkK6D
         yjuZ4vy0SrHAFnRfvNWq/bYbu4MEbp1CnEv/yoSTlLmlrdiBd4OxoLBQsZy0Oy1QjQ7F
         oriw==
X-Gm-Message-State: APjAAAXCsPN6RukW6oSxjjz1VQNYZz3yT736IEUA0VuRbzILBgm0KEKQ
        dJ+GszA+9Xh6/YR3JkuQD0HTug==
X-Google-Smtp-Source: APXvYqxyVzPC9IoxOLKDts628XWv6OkrfIirzaprUaYuA7AlwNUSiNFN1GO1i7qw0lRjk+2T7cp04A==
X-Received: by 2002:a17:902:347:: with SMTP id 65mr61865215pld.232.1558336079127;
        Mon, 20 May 2019 00:07:59 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id c2sm24319974pfa.18.2019.05.20.00.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 00:07:57 -0700 (PDT)
Date:   Mon, 20 May 2019 12:37:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] dt-bindings: cpufreq: Document
 allwinner,sun50i-h6-operating-points
Message-ID: <20190520070755.46y7k4l5ya2mdjdn@vireshk-i7>
References: <20190418125538.25722-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418125538.25722-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-04-19, 08:55, Yangtao Li wrote:
> Allwinner Process Voltage Scaling Tables defines the voltage and
> frequency value based on the speedbin blown in the efuse combination.
> The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> provide the OPP framework with required information.
> This is used to determine the voltage and frequency value for each
> OPP of operating-points-v2 table when it is parsed by the OPP framework.
> 
> The "allwinner,sun50i-h6-operating-points" DT extends the
> "operating-points-v2"
> with following parameters:
> - nvmem-cells (NVMEM area containig the speedbin information)
> - opp-microvolt-<name>: voltage in micro Volts.
>   At runtime, the platform can pick a <name> and matching
>   opp-microvolt-<name> property.
> 			HW:		<name>:
> 			sun50i-h6      speed0 speed1 speed2
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
> just fix a typo:
> sun50iw-h6 -> sun50i-h6
> 
> This patch is [2/2].
> for [1/2]:
> https://patchwork.kernel.org/patch/10903381/
> ---
>  .../bindings/opp/sun50i-nvmem-cpufreq.txt     | 167 ++++++++++++++++++
>  1 file changed, 167 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt

@Rob: Do you have any comments on this one before I apply it ?

-- 
viresh
