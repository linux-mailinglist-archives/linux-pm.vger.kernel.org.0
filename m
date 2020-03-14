Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA64F185880
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 03:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgCOCNc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Mar 2020 22:13:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37762 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgCOCNb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Mar 2020 22:13:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id j11so11078429lfg.4;
        Sat, 14 Mar 2020 19:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qTvsDZK0rxtwgZonA0VJoQgg0bPgzs3j6WHVwR4bqZI=;
        b=e++v7FGumBHI5+HlPttacUzXNYkzBpwoSjrwE6ufSCCWq+gtInkpm0Bx9RD0GG59nI
         4IZOu3SsjDH0yTUHVeYjGLZAST6etZTomFkJNYfRYf5qCC03mfK80Z2hbvTW+CQEoa8n
         L88Cm+xJ3l71HpglYeMmaQmjLkInsaVMtKF5NPIN0ihfSwmD9jMkcQ3QUXgQWl072SLJ
         eQ6WB2vf2Ycj/DCYenSBDFwktrDeErYWuW6Z5LPMhqrA73LaN3EPwhLON4OMQrl9CAPX
         w9JXeiBVOh4vm/sn0W5sTSx433M/Ip+OPyHOOFNjYE/RSenUzXxj1dbuSt5v4PJGIVtW
         JQnA==
X-Gm-Message-State: ANhLgQ27Q1aa53TymneA/HvK1YsVsCsVlNGyDJkA6FTAzUYbpfTkboiW
        hLsdhkGPVSsoj2WxY4XLkwOVuXDw
X-Google-Smtp-Source: ADFU+vuapXjT+zS11FjAUnN+oE9D5lHJ2QsCXnjtSRTI8yMnWnss9ph50Wosr+69IEUAzQJDJH9pXQ==
X-Received: by 2002:a17:906:7a55:: with SMTP id i21mr16361531ejo.303.1584211535391;
        Sat, 14 Mar 2020 11:45:35 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id d23sm1122777edr.33.2020.03.14.11.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Mar 2020 11:45:34 -0700 (PDT)
Date:   Sat, 14 Mar 2020 19:45:30 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] extcon: max14577: Add proper dt-compatible strings
Message-ID: <20200314184530.GD17580@kozik-lap>
References: <20200220145127.21273-1-m.szyprowski@samsung.com>
 <CGME20200220145135eucas1p123c4e4523e7e6eb86b64e728d6931cee@eucas1p1.samsung.com>
 <20200220145127.21273-2-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200220145127.21273-2-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 20, 2020 at 03:51:26PM +0100, Marek Szyprowski wrote:
> Add device tree compatible strings and create proper modalias structures
> to let this driver load automatically if compiled as module, because
> max14577 MFD driver creates MFD cells with such compatible strings.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/extcon/extcon-max14577.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

The approach is still being discussed (in patch #1) so this should be
applied if patch #1 is also accepted. In such case:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
