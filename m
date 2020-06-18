Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C311FED5C
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jun 2020 10:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgFRIRz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jun 2020 04:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbgFRIRw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2020 04:17:52 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7508EC06174E
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2020 01:17:52 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j198so6115189wmj.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2020 01:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IOYUmd9PSpuXYK1ISNi+ysM7p96iX1XCm0TFfaj58uY=;
        b=xmh8AZJzymwZPG22MQt90aZEYCEz5YNiX1qpslNov676+ulSSCp4HOOV+2wtdJqTpR
         ngWPEqIFX7RjQ5pCic04SRjPtNNrLiMtd4ypa+Zq94hZP4X7co5Fxf3c6GWQibIQTE71
         AxrhdeQ4DeBnjiNhLNcqtqaxzs79Qn2V/UEHnmkMK5g+iOrrobg3yFF0JSDBvgLqalM1
         zBy1ctV1NU1N90eA4kKUuLHBENFS9Dyo4kjNkHERqts24wABYer1QmVBLHR/B0eqoMit
         jrQ9KOJWlBym6Uqq1EazOMmi3HB2PGQ4QAd0pKmE2BIxfqUOT4MpBi4dYuU/DM6Af+Eb
         zWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IOYUmd9PSpuXYK1ISNi+ysM7p96iX1XCm0TFfaj58uY=;
        b=QKTkCA0zX1cAp96mBj3PwgQBeb0ugVf/jPbm4QnCigQo8gnFRSjjbEf+ZeUFPKlpdE
         MYRhy9H2vLOtJcgcis0GG+N8jvcCRftz4osIkqNYOV2j9E2GA7B5qGIjeNppXUyDvToy
         qJNWtKuAoJD6lw4RdvtsVcVWe66g4eMHk7ddEzHypsQEK4DQAv/16HHyml9yUxCbx+3l
         khlg0MbdIhGZM/JnREPuI5ta8/3W37IV8Sq7FZxkMYakmnE+Lur1qMKvOTKiIbMgeiEF
         OuxqiWDQU5by36ss4IsOMdGUvnOBTKMzdOAIc+z//gObtIbFHwpUj/e3YxN4s1C8g0nS
         FZqA==
X-Gm-Message-State: AOAM533EawqvNIjIBBbXWW83/iMKRUZRE8z6Ewvc4mNgSSN7siyLbpH3
        U2jTfTvH3wSaVO7qZSCKvYGQgg==
X-Google-Smtp-Source: ABdhPJwKpbM6Xp9xV0ze78/9eiiEEdNa17lnGotX+3haobW7ajRUeWd4V88Vlxhosh+HogH2T4LEtA==
X-Received: by 2002:a05:600c:22c9:: with SMTP id 9mr3032932wmg.68.1592468271250;
        Thu, 18 Jun 2020 01:17:51 -0700 (PDT)
Received: from dell ([95.149.164.118])
        by smtp.gmail.com with ESMTPSA id z7sm1472713wmb.42.2020.06.18.01.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 01:17:50 -0700 (PDT)
Date:   Thu, 18 Jun 2020 09:17:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-amlogic@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] MAINTAINERS: add myself as maintainer for Khadas
 MCU drivers
Message-ID: <20200618081749.GC2608702@dell>
References: <20200608091739.2368-1-narmstrong@baylibre.com>
 <20200608091739.2368-5-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200608091739.2368-5-narmstrong@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 08 Jun 2020, Neil Armstrong wrote:

> Add the Thermal driver along the MFD drivers and header as Maintained
> by myself.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
