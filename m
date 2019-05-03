Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE7F212B18
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 11:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfECJy0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 May 2019 05:54:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43020 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfECJy0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2019 05:54:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id t22so2481560pgi.10
        for <linux-pm@vger.kernel.org>; Fri, 03 May 2019 02:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C0o2C2dvxi0pLMdXrDdXumezhHQvfHIWUdutqFX4avo=;
        b=CmgJv+ovQfwvMZ8hYrU6a3KAmlaqUCKfjDSp83hy2eKiLdEJ4JPXjrBJqG14F9XqA/
         63eOwi3EkVjl+6D/641S48T8xo5/+soZmiSsx8FZG8MJNjuvkgpCckX5B7TdvVcx7LGV
         f+xOAwRPKBwwoRwKkqvQ+vDiOq7OhkELe3l6uvDfjSQDo1VC3gSVoa22s2Q2D7S0On1w
         wgP3TRWiWVyVbqssaGJTP4T2Q8KqSekqh+Buw9TLma8BXAJFkwYJBJaMHWjl+sVhdII1
         RtireCfFfJXDEh0wbQIcmVPQeuxSoPZwj1SU2QM9oQST4DJ1VMOWRQuzuNsvvBtrekmx
         8JJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C0o2C2dvxi0pLMdXrDdXumezhHQvfHIWUdutqFX4avo=;
        b=SRsRJ9+PGUQGSf0NIi2aacx9DwchJQD1aMJf/dF8x3tHpSToYlQgJPrADLmhnXm+R0
         JKH+UQe2h+ggOm7J5m/lv7nYiva6vo2H60GCltt+jIwX9Vdwkim2D/26BCaN8snkcSTY
         F90rAEk3XM0nB6KO4fhrzP1XuSrRBetrBw1bQPDax+R+hwQt6lkzyAFcSc51alQndJZK
         iIlwPJ3iugPbqS6QheVN0M8eE5prr/Ya0/ywpjbcyOiCbviYotKRYpa+DlZi3NHyjERK
         QPk2zMd/izBlCutvjQHIJxjNh5WJBoWKgdeG4yI0jKwUtvsjn+7fHs/6QQ/XlJ04T7wq
         niEg==
X-Gm-Message-State: APjAAAVZBtSw2ETBunhiR6FWBMnC46+3kzo1+DEIDyfYLsnBFkXwdI2M
        zAiSriboDZNWtQt9e0Ll6UYO4sW81fw=
X-Google-Smtp-Source: APXvYqwvKwHE2OHYzzhBFYFV6Lf8kjUsbmnwDw43+ppDTskuURRW+KyLhklRJn7iA21MO0JSDONaUA==
X-Received: by 2002:aa7:9151:: with SMTP id 17mr9215458pfi.192.1556877265425;
        Fri, 03 May 2019 02:54:25 -0700 (PDT)
Received: from localhost ([171.61.121.242])
        by smtp.gmail.com with ESMTPSA id x4sm2353103pfm.19.2019.05.03.02.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 02:54:24 -0700 (PDT)
Date:   Fri, 3 May 2019 15:24:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com,
        catalin.marinas@arm.com, daniel.lezcano@linaro.org,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] Make IPA use PM_EM
Message-ID: <20190503095422.dw5ssdd6bz2wxaqn@vireshk-i7>
References: <20190503094409.3499-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503094409.3499-1-quentin.perret@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-05-19, 10:44, Quentin Perret wrote:
> Changes in v3:
> **************
>  - Changed warning message for unordered tables to something more
>    explicit (Viresh)
>  - Changes WARN() into a pr_err() for consistency

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
