Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD574105B7F
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 22:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfKUVAM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Nov 2019 16:00:12 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42408 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUVAM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2019 16:00:12 -0500
Received: by mail-oi1-f193.google.com with SMTP id o12so4501193oic.9;
        Thu, 21 Nov 2019 13:00:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SxSot6EgZMv6I/ipPn5GJ1W17H/FceWiJqLiGTJUw7A=;
        b=chBHXB2FeyJYkwYfTeFLaiHGY4B/l8uGUhg7WuP5dPKTzs6PVLl+DWB/sTfD6si5YK
         NirU/ErKuelKLfDlXzPhj/5NmEAc05btTegaRsx0a2ZEp0l5U0CQk78hWQnAFDqOURVR
         1BiNQYvyoqqKxrmHSzzKIWaa7btl2L7k/QSxzXXknVA5HVf6HwJLI52LKCwCAMQ2Ytjt
         uXsoG8dw2ULGQdi1l/6Rp+Z1aD+R/Sb0GCT0y2u+NMPJ6Nji7Tu6r7Dm53FzuHOaYvbj
         HU8oc1G1eT4P03VAt0i5wiGki/1eyL4Gr14bfnlcvqFpqyioewXbXNL5OxSyVvAV+ZhX
         Jxxg==
X-Gm-Message-State: APjAAAWBCfMLlcsJXiU8A0L3Z0RqFmTYEoe3IhBNJTuwvVhKqRIf/ign
        PXuuC75jJbTz7FT6jcgWjw==
X-Google-Smtp-Source: APXvYqzZRrFiuYK7K/Obo8SgGAjOF7Ow3hwd08fXejCVDmPvcemJ1lgWEhImSfx8sFpl48Lx+9CNfA==
X-Received: by 2002:a05:6808:117:: with SMTP id b23mr8902981oie.151.1574370011370;
        Thu, 21 Nov 2019 13:00:11 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p3sm1377017oti.22.2019.11.21.13.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 13:00:09 -0800 (PST)
Date:   Thu, 21 Nov 2019 15:00:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 3/5] dt-bindings: memory: Add bindings for imx8m ddr
 controller
Message-ID: <20191121210008.GA20656@bogus>
References: <cover.1573756360.git.leonard.crestez@nxp.com>
 <58f3aea574bf3a38a42075e313fc2a5592c96ed2.1573756360.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58f3aea574bf3a38a42075e313fc2a5592c96ed2.1573756360.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 14 Nov 2019 20:33:20 +0200, Leonard Crestez wrote:
> Add devicetree bindings for the i.MX DDR Controller on imx8m series
> chips. It supports dynamic frequency switching between multiple data
> rates and this is exposed to Linux via the devfreq subsystem.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  .../memory-controllers/fsl/imx8m-ddrc.yaml    | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
