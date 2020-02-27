Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E77441724B4
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 18:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgB0RMa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 12:12:30 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44924 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbgB0RMa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 12:12:30 -0500
Received: by mail-pl1-f194.google.com with SMTP id d9so33543plo.11
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2020 09:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LOyT5HvsVh4qMzW2jHlKrfdY1wfzL0iwi9fyqr1yxSg=;
        b=PjgAbV5itjXELWeRURFWOnDxWWgcVNwTRbKN2F+s+aCnI9XkbVuKaH4FNVfqdZu4G5
         yaJvoev4JVjgNE6vi+yAEwMkJYjpq08qN3rOQ2jp1J56AjF5IG+vP5TnBmhH4OwFiWh7
         qq+AMuXQdOVTlquHBCsVZzjJP9BHQdHP1sa1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LOyT5HvsVh4qMzW2jHlKrfdY1wfzL0iwi9fyqr1yxSg=;
        b=pJ4Wh7ccLMkJ9/gtKAPPJVLSsu6w5XyPzwYk0jfOJC5oP7DY0Z+nvHdmTm1jYQKLcX
         z1dxfdwt/ABfKUiVGX69zYMjQcE+FL4NKBKqtWB2iSOFDcbzvNtVcDu6E5LsgcZi62qX
         tv6h3u5K5DEys4F9PWfZgZuMW3M6phfsuw9+3LNEKxipSBwhyVaOKWR8vPh3FljsuN4z
         C8/TKKyIZyDUz4E7jWGkmkDHwqj7t82fA9pDuCp/rpqswXQHANivTw5NbvgVIuTB75kq
         a6oWGb1b1cOwTEThDcYxQ/stbv57tivFi1l/qcUp531oEc9ZBXWIhnLkasKLNv2w0nqo
         vGyg==
X-Gm-Message-State: APjAAAUwpyrNpugQxDqFniqmFU304XIS+qmGj+OqZaDVoqDLqVw2H+PZ
        0KBWT/5DTLSEbYVd5DtP5syVZQ==
X-Google-Smtp-Source: APXvYqx6fZfhqq+ecXx0OzqoQNR179JoYOMacTaNfi38ToDP70lt0Yh233FkLgWk5lXrSVbcwJbSvA==
X-Received: by 2002:a17:902:8f94:: with SMTP id z20mr741978plo.62.1582823549030;
        Thu, 27 Feb 2020 09:12:29 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id k1sm5789477pgt.70.2020.02.27.09.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 09:12:28 -0800 (PST)
Date:   Thu, 27 Feb 2020 09:12:26 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Odelu Kukatla <okukatla@codeaurora.org>
Cc:     georgi.djakov@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@google.com,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        ilina@codeaurora.org, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [V4, 3/3] arm64: dts: sc7180: Add interconnect provider DT nodes
Message-ID: <20200227171226.GJ24720@google.com>
References: <1582646384-1458-1-git-send-email-okukatla@codeaurora.org>
 <1582646384-1458-4-git-send-email-okukatla@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1582646384-1458-4-git-send-email-okukatla@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 25, 2020 at 09:29:44PM +0530, Odelu Kukatla wrote:
> Add the DT nodes for the network-on-chip interconnect buses found
> on sc7180-based platforms.
> 
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 95 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index cc5a94f..3e28f34 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi

v2 had:

+#include <dt-bindings/interconnect/qcom,sc7180.h>

I think we still want that, otherwise some patch that adds an
interconnect configuration for SC7180 needs to add it (see also
https://patchwork.kernel.org/patch/11386485/#23187545)
