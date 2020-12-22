Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3601F2E074A
	for <lists+linux-pm@lfdr.de>; Tue, 22 Dec 2020 09:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgLVIiH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Dec 2020 03:38:07 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:39475 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgLVIiH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2020 03:38:07 -0500
Received: by mail-wr1-f48.google.com with SMTP id c5so13649002wrp.6;
        Tue, 22 Dec 2020 00:37:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L7VUupdwNKXioiFOmlRnQkfKJa6jZJuHBhu7Vo4dJ4M=;
        b=k8X+ap1wCDfTMtAw4UVTaE6C4r1uAtRl7EAfoQ/yMyiBMgxUxkd4GBiDuCpC1+5vbN
         ZLr8YnB74NWJbLF7JcG4e+PHrU2FC5qeIqs6y/t9DQ5sKCrILLpnZy9iDhK3J6f5otG4
         y/JOcRW7Cu6Aj/bBN/VjXcSAGbSt1lYHPnFLNx3OzElyjvdYem6kVOxqNbwlaBB7vHTj
         Hn4DRGgEFfKMdGM6iILHpUpg5isLZNJ9aOsxB5xr+m2wdhuWzv01JPdWuvdIrb9XK2kH
         3ZNXan8E2Q8PO/P/4frFBhk1swhotxHy0WkOqPBkmo4tZp6VVMmqblJEOMLiRc5EQsd/
         k7Zw==
X-Gm-Message-State: AOAM533uYJyb50uDPlTSARL3jg3xKnoUA5nL9SYyHoWByvzJ7UgTCymZ
        UcwrzZUD7P063pLp4lnxWQg=
X-Google-Smtp-Source: ABdhPJy4bDDXomIKstNtdXKh1RyDFfWuauh6UN/7NZ8qIwAkneojarrmfS4jrRmwLK5kMW83KV+cAw==
X-Received: by 2002:adf:c14d:: with SMTP id w13mr22491009wre.383.1608626245596;
        Tue, 22 Dec 2020 00:37:25 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id w18sm31476679wrn.2.2020.12.22.00.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 00:37:24 -0800 (PST)
Date:   Tue, 22 Dec 2020 09:37:23 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 2/7] regulator: dt-bindings: Document max8997-pmic
 nodes
Message-ID: <20201222083723.GB5026@kozik-lap>
References: <20201222070520.710096-1-timon.baetz@protonmail.com>
 <20201222070520.710096-2-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201222070520.710096-2-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 22, 2020 at 07:31:21AM +0000, Timon Baetz wrote:
> Add maxim,max8997-battery and maxim,max8997-muic optional nodes.
> 
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> ---
>  .../bindings/regulator/max8997-regulator.txt          | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
