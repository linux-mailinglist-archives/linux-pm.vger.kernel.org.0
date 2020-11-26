Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A8F2C5B2B
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 18:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404442AbgKZRzq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 12:55:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40226 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbgKZRzq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 12:55:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id m6so3027045wrg.7;
        Thu, 26 Nov 2020 09:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BPRszRD8WTfKhM146jvwE7ROJeb/YEp7F6Y/2g9JDi4=;
        b=WuWVn0V6EHEg4N96aQpCrsX4a7alnybpn+0ftAtx4tHsmfRO/tYhmTa8GU+djodjME
         qTod6AGL9kDso4IlfcE6V1kMS0S2OhuKWtX3iM6LqqbdniUXw0ATWOuS6i6PL9+6wb2p
         5EZS4Wk4pxt/p8VNIfVxBsuOjioMCW1qTGgmi96WcD4PQnQSqJPHRgbF5EQXlxORjJa/
         dAgLhx6+F65d4CRKrecCk2da1i4lAtb9JkS6rtqJd/pFk28AL0hpL0TVV7oTGaCBMR+N
         9VQQgu3ONBXFyrymwe1DVlIwEGVrVcUxRMFYSPkzmYABYuU71GAm8PVCZe3V9lFHqF1h
         LgIQ==
X-Gm-Message-State: AOAM530g4NXcRL2UOU5/ZKTRPWgA9mhirZBgI5RfZjM/qCctlqWdmdyE
        MxRyERm8SpJWDYhgT5XYliY=
X-Google-Smtp-Source: ABdhPJxsxYEkexSA/U6bdyPrIywe4NRgTwpSBxzuJu8phtScvujbHSVPGbFkYB7FIJgapImAMRqbow==
X-Received: by 2002:a5d:44c1:: with SMTP id z1mr5157850wrr.375.1606413343777;
        Thu, 26 Nov 2020 09:55:43 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id a21sm8938734wmb.38.2020.11.26.09.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 09:55:42 -0800 (PST)
Date:   Thu, 26 Nov 2020 18:55:41 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 18/47] dt-bindings: memory: tegra30: Add memory client
 IDs
Message-ID: <20201126175541.GB17141@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-19-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-19-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:48:54PM +0300, Dmitry Osipenko wrote:
> Each memory client has unique hardware ID, add these IDs.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/dt-bindings/memory/tegra30-mc.h | 67 +++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
