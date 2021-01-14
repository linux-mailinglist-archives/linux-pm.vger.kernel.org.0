Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C922F6318
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 15:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbhANO20 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 09:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbhANO2Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 09:28:25 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39499C061575
        for <linux-pm@vger.kernel.org>; Thu, 14 Jan 2021 06:27:45 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v15so2296504wrx.4
        for <linux-pm@vger.kernel.org>; Thu, 14 Jan 2021 06:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=stURBibHeymSTQotO4y7jVW0jLXFO/bJV0OvfHx8/Ow=;
        b=fhyQomvCom1FnwqmnHAbPTCnd0LMPSC1mqIoFA5OZ1Zgg17bwZDLU5KO1gmbEBqcIp
         YXIPhQ0GvJBZ7V4KjAkdpNk8Vbr3fPg1LUcu9POniajMxCP0erZ1u88GCrBaFhiy+FdN
         tVDBg3CRCCKH4azQ0/EPNm434Xan+AeW3X7wmtOgA31CDosXjFEBvXxYcwUw+jT9uHvJ
         /WPpe0HcdoOnSgatKDKfXg1geiL7eYH29nuVy1BmcqevKsMAOEaO5vZnZUnajjI790vs
         9EaGJwjx+uFxrvuvwjVLycDv3gsRr8yowd8eunI72m69qv1qrUNBzpNbP/lFKWbKiSIO
         3yQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=stURBibHeymSTQotO4y7jVW0jLXFO/bJV0OvfHx8/Ow=;
        b=Ugn2db9zV89O0+AcgzLsTb3RXPC8L+cJ6246KbVbyPIa2i/Wyo2ZPrX+cTOCvtLlUI
         1Jip0JsRKqU6HBK+Zmt1E+iC9yVFwrrJRn9FBGyPNSYvcOSVPQxB/n/F6EGdDYMv5Izw
         XxWE4uEEhIRUi16Ujez8C/fJasAleETKjmL7AmrtD5z7cbnB8XRwocLX0yiqOw4D4343
         D7/e0oM7pOPKzb9WXUyq5FQzRESJBZpbc49dBBEJoLFL2Dhar8MDcwa/awqEDTEnFwYG
         /64PVzzR6L+dD0HMSA786mP7k4rEM6yEQv0p5o4cH7DymlJGccv+XDNXOwkFqn+Achqi
         gnAA==
X-Gm-Message-State: AOAM5316doiSZ9ri+o5TIh9yqFygK2eC4N7x2YYoNNRbqZPqD8AOw5+T
        8L4/ONKIrJGHDxb6xVDzAcG77w==
X-Google-Smtp-Source: ABdhPJyXrFe2m39uAyQy2h7tZOKGTMg+Vg9rbr1bpTyqBQ3zqWU671dcf51KtVjNjgEuIROfT8ikKw==
X-Received: by 2002:a5d:45d0:: with SMTP id b16mr8085208wrs.220.1610634463919;
        Thu, 14 Jan 2021 06:27:43 -0800 (PST)
Received: from dell ([91.110.221.178])
        by smtp.gmail.com with ESMTPSA id l7sm3707755wmg.41.2021.01.14.06.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 06:27:43 -0800 (PST)
Date:   Thu, 14 Jan 2021 14:27:41 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] dt-bindings: mfd: Add ENE KB930 Embedded
 Controller binding
Message-ID: <20210114142741.GZ3975472@dell>
References: <20201228160547.30562-1-digetx@gmail.com>
 <20201228160547.30562-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201228160547.30562-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 28 Dec 2020, Dmitry Osipenko wrote:

> Add binding document for the ENE KB930 Embedded Controller.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/mfd/ene-kb930.yaml    | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb930.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
