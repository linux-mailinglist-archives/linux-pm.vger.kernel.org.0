Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A69F92209
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 13:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfHSLSk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 07:18:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46562 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfHSLSk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 07:18:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id c2so814570plz.13
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 04:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+0JHVJ6vLP57lu0mVcK3az5uoceXnYkV/uG2YnQJlFc=;
        b=yHvLt0Lqcb9O8pCS28X3oB0TkDb1X6NWvoLOSLok1pdmLUebRybtLcc/QVJYMDiGdI
         X1a9kvGLCqr3QU6LlKSeWFJPDuJM9aqVFndIz+MGlkMvOi0+AEc8DdZ8AE/RfZkEWKqL
         RF8Z2wgL2Y7XyOXj4P1FSMOcjOv2ELEW/kleU2VQGLqXj4dsVDB/M2TzyEcPsASqvjcW
         Sl/VjLG36MbKp+HKiLkfFnsXeK7GOUDvrbr4qSkOk6MaXf1XyG0CKC018GUyItmlUPlB
         BmHDfdzGU2Hx1N9xGdUzeCVP7hBkUfM2FZdoS7VY+JS/an1HGuQMPVAMfwC3vQ6jInDz
         SvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+0JHVJ6vLP57lu0mVcK3az5uoceXnYkV/uG2YnQJlFc=;
        b=M5OFKzz/3EEx30ga7nEbVjrULzcU8sfI6S/ud4E0oRCYoRd8TdhBP+Ea8THgHZlusk
         lyP/mtUVuvwW1jVqA0aF3uv4nx9nZ1BRfe+mY9Z2UwE4MviF1L2hs4zqkqyPbkbS2M6x
         EpjHs8ITj5ITCv7GuR77ycWyfWEniTzLEg0sQNDM4+TRn/CkC00F5xEYjBaXyb6U/Bg0
         Jv0HE/rnNEhSZo/bGuqRy5KuTzLlNip/0cY/TqIttD0opgPJFeFyqr/pQOf8AECbXyAJ
         QZ2u6OovPyP/ffM482cXM3Uyny+zUBABPwDXTTguW67ZoRqbo6b8FM81VSli57R0ZcXB
         dvMA==
X-Gm-Message-State: APjAAAUaoebogOPWV6rRr2FIuCvkP5CJWcLROz7xdxb74Yi7SZjYA732
        GNQX+4hmW2JJEfQaPuIjQMk3Rg==
X-Google-Smtp-Source: APXvYqyeim3wFsyNXQj/i/RDQRhJjEOMjrjuOoydnB1fIrDDwTjwzY2Z5AOdrzw4HJlIotmEz1cy5g==
X-Received: by 2002:a17:902:f204:: with SMTP id gn4mr22280443plb.3.1566213519598;
        Mon, 19 Aug 2019 04:18:39 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id k3sm26078163pfg.23.2019.08.19.04.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 04:18:38 -0700 (PDT)
Date:   Mon, 19 Aug 2019 16:48:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, fan.chen@mediatek.com,
        Stephen Boyd <sboyd@codeaurora.org>,
        Roger Lu <roger.lu@mediatek.com>
Subject: Re: [v4, 6/8] PM / OPP: Support adjusting OPP voltages at runtime
Message-ID: <20190819111836.5cu245xre6ky6xav@vireshk-i7>
References: <1565703113-31479-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1565703113-31479-7-git-send-email-andrew-sh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565703113-31479-7-git-send-email-andrew-sh.cheng@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-08-19, 21:31, Andrew-sh.Cheng wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> On some SoCs the Adaptive Voltage Scaling (AVS) technique is
> employed to optimize the operating voltage of a device. At a
> given frequency, the hardware monitors dynamic factors and either
> makes a suggestion for how much to adjust a voltage for the
> current frequency, or it automatically adjusts the voltage
> without software intervention. Add an API to the OPP library for
> the former case, so that AVS type devices can update the voltages
> for an OPP when the hardware determines the voltage should
> change. The assumption is that drivers like CPUfreq or devfreq
> will register for the OPP notifiers and adjust the voltage
> according to suggestions that AVS makes.
> 
> This patch is devired from [1] submitted by Stephen.
> [1] https://lore.kernel.org/patchwork/patch/599279/
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>  drivers/opp/core.c     | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h | 11 +++++++++
>  2 files changed, 74 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index c094d5d20fd7..407a07f29b12 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2054,6 +2054,69 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
>  }
>  
>  /**
> + * dev_pm_opp_adjust_voltage() - helper to change the voltage of an OPP
> + * @dev:		device for which we do this operation
> + * @freq:		OPP frequency to adjust voltage of
> + * @u_volt:		new OPP voltage
> + *
> + * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
> + * copy operation, returns 0 if no modifcation was done OR modification was
> + * successful.
> + */
> +int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
> +			      unsigned long u_volt)

Can you please update this to take a triplet instead ? That is what we are
storing in OPP core now a days.

-- 
viresh
