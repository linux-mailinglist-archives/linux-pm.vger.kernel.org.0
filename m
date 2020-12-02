Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5772CB622
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 09:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgLBIDG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 03:03:06 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:42424 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLBIDG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 03:03:06 -0500
Received: by mail-ej1-f65.google.com with SMTP id d17so2111428ejy.9;
        Wed, 02 Dec 2020 00:02:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PyHUsdrSQLc+DnSBZDlYlfRfMM70OqLfIdi+Clca9g0=;
        b=b9sfmqcSO9bo8SrDsGrYRYksY/cmqUCtJA9igmndVrNEwLL8XKCYQlO6UbQDKnOQAy
         V42hNMJECRf/XbSyinCYElDZW4vI/odcSmuXPJxOOY/cZpIVxeNNV0OHN0lJ4b8ukiWt
         QXuy3Le2mKnQrk7zV5pTVif2lvP8Zao99tyVHvQIWraPiaFg48Nd4LZlcOE4EHZ0Obv/
         BW/XBlODfoXHeEqv1uoj6sAtQ+x1Y0G4Ax/N2zPyXzEfqxBRUYTLCadddAVqZLL9xEE4
         HNTANmu9MzslFCyuDC9YZGYYZhPjWV8ZpdiJfgmKhISrFIgFBH6rhzcddY5cHQQ8WWTA
         iZdQ==
X-Gm-Message-State: AOAM531fxkJwixcs7WOoVi8fDivHIgldarq4alhhjL9UKz7fSKJlQ//q
        gR3cqJJwjFufga/xu7jmEKE=
X-Google-Smtp-Source: ABdhPJzNvuyFfqt/f9t/p7FBQ+5kROv3Zx8oo1e+YQ5vEg11IdZRCLUgrH9jZ4ejbCyXAB6LCtXJzg==
X-Received: by 2002:a17:906:4d8d:: with SMTP id s13mr1171906eju.305.1606896143947;
        Wed, 02 Dec 2020 00:02:23 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id c25sm570633ejx.39.2020.12.02.00.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 00:02:22 -0800 (PST)
Date:   Wed, 2 Dec 2020 10:02:21 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, georgi.djakov@linaro.org,
        cdleonard@gmail.com, kernel@pengutronix.de, linux-imx@nxp.com,
        kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 7/7] arm64: defconfig: Enable interconnect for imx8mq
Message-ID: <20201202080221.GA6087@kozik-lap>
References: <20201201123932.12312-1-martin.kepplinger@puri.sm>
 <20201201123932.12312-8-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201201123932.12312-8-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 01, 2020 at 01:39:32PM +0100, Martin Kepplinger wrote:
> Enable INTERCONNECT_IMX8MQ in order to make interconnect more widely
> available for testing.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  arch/arm64/configs/defconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
