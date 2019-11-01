Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC2CEC5A5
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 16:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfKAPa5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 11:30:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33434 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfKAPa5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 11:30:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id c4so7860482edl.0;
        Fri, 01 Nov 2019 08:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dTmT4eDAKSsUmLuYHZ3sJmr/cB9F+1oZoiLUZ0VRUI4=;
        b=NEkJGd9HpxQDYw8gPk9tvRRCSu5ACCRDHBWDTcWbGh8gavY3e+AN8X4TDIaMFudD/d
         u9GLWzhxYcUNapW70Z23zFm+b8NxdYj3FWua2d+punTJvNw9YFseyeRIXQOeB4ZYLsMN
         EzSGUoLISK11ZrZCjQehLt2K2eudcnYfVaUQSLuLIoQdAWDlRSMlpdTRl/FN5FJcxL3f
         YWue2Pcr2wZQRp9UnEt+mKIZcrhuJnpJfMoMnrtalaHWtKUztZUv45qCXFuZ2yZxqwSM
         y0PXhHo7RxkJPp6tkhfCSYXyIDQBHV1wwA7htIqgl6Hw7hvsuR54vIgjGvKCZtte3cl9
         rqKg==
X-Gm-Message-State: APjAAAXTToynOX3wb9GHl158Nz+UFm7UhMfNCrWh9ePTd1H4SsJotTRD
        M47Ypxd7uGjUeP7vdSvQOsc=
X-Google-Smtp-Source: APXvYqwHLXBlTk3KX1PlXWsYFgm5sRXnYCAsqetUcbhAcnIu+qpuYwzU6se4PgHigqhu0YAtjb6GtA==
X-Received: by 2002:a50:9f65:: with SMTP id b92mr13305037edf.63.1572622255102;
        Fri, 01 Nov 2019 08:30:55 -0700 (PDT)
Received: from pi3 ([194.230.155.180])
        by smtp.googlemail.com with ESMTPSA id d15sm189625edx.78.2019.11.01.08.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 08:30:53 -0700 (PDT)
Date:   Fri, 1 Nov 2019 16:30:50 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com,
        lee.jones@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] power: supply: max17040: Send uevent in SOC and
 status change
Message-ID: <20191101153050.GD28931@pi3>
References: <CAJKOXPdCtbsPaAgYp5iVBhkAsjXzOYWwttQBptgiUgzhbKi09w@mail.gmail.com>
 <20191031184134.30621-1-matheus@castello.eng.br>
 <20191031184134.30621-5-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191031184134.30621-5-matheus@castello.eng.br>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 31, 2019 at 03:41:34PM -0300, Matheus Castello wrote:
> Notify core through power_supply_changed() in case of changes in state
> of charge and power supply status. This is useful for user-space to
> efficiently update current battery level.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/power/supply/max17040_battery.c | 9 +++++++++

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

