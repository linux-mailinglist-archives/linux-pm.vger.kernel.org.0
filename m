Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4FB9EC86
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2019 17:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfH0P0m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Aug 2019 11:26:42 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43292 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfH0P0l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Aug 2019 11:26:41 -0400
Received: by mail-ot1-f68.google.com with SMTP id e12so19031742otp.10;
        Tue, 27 Aug 2019 08:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dTabeQNKIt3DMf8V0lSBJbBI/KH3E3xsfnhmOPLsomA=;
        b=R7mZkbyu43HHUB/SzsM56uljTo0/0x2n0kDJjPgDzJP2blUWszDFUi8xWArUNWDGoA
         XsFofk3fzhCJDz6fvPdm/ovT7hMDg90LZ+JBiE19tI8bcdvNP6/2PTzvRZesj2YWXSPP
         KbmwznZq0lCzgyC3NZcU7aWHr1NNsNnuH0Q1NDe8rih3eSH7T8t6AAbq7DGCwzNsqZ2+
         pJESvXtNftqyl0WSRbTQdPBfMhahaBhOOSKCtw8uHJs0XozjAbQFVZp6KJbuwV8ZrfxF
         3Yoe44x0efwvjkxX1JTixQUy+vBO2C8Rr3MsMaO2qS8pXCU1o+TRd5SIbk6LSj3Yrzh0
         HTxA==
X-Gm-Message-State: APjAAAWhxH+Pjvhm1jNi2MzAZm9uF2oTI4YNj7/EIOJqiMiMCirZIyOv
        7sUQYmZUHFXzSn5fmLbXjQ==
X-Google-Smtp-Source: APXvYqzyhZACPtTqUFIzED5uPoZOA1rJSVxC3AZ5Tb22VDqDkoAUxKSKXJLmHkRDTp9/KaCYI1XFaA==
X-Received: by 2002:a9d:6a4a:: with SMTP id h10mr2300487otn.260.1566919600784;
        Tue, 27 Aug 2019 08:26:40 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d27sm5377657otf.25.2019.08.27.08.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 08:26:40 -0700 (PDT)
Date:   Tue, 27 Aug 2019 10:26:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH v5 12/18] dt-bindings: thermal: add binding document for
 a64 thermal controller
Message-ID: <20190827152639.GA25694@bogus>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
 <20190810052829.6032-13-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810052829.6032-13-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 10 Aug 2019 05:28:23 +0000, Yangtao Li wrote:
> This patch adds binding document for allwinner a64 thermal controller.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
