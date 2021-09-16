Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD5F40D135
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 03:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhIPBbI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Sep 2021 21:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbhIPBbH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Sep 2021 21:31:07 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CC5C061574;
        Wed, 15 Sep 2021 18:29:47 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g1so11790519lfj.12;
        Wed, 15 Sep 2021 18:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=raE0bEyLLL3+Nq2kPEBUvBEq7TdRxkLowLoERhJ9/Ac=;
        b=g4j15rkhckQxjBYnwq/XrEcUjCxDj6ZTKy1GTedrX3/dltIG/YDibwMXCH+hiJ7KkU
         VajoY8i9whD/8NRmVLMKxU0XnjaaFJHsbDOobW3ZobfyaV9dqYvioCVwN5GQsTcSZBr2
         Ycr0UaB2x4YTthafj8t6Nl05d4FhIwid8f39orpGhbMCK1Dm6ayMkqNnY1AnGsxW4hXa
         ZizJynUA9QNJGYRLJfjsmKzHzokvIYHtH9Qd+ZepEJCwmo2svbf6y327iwx3P6BFLC0t
         qyYWtjl5jP6S991arDnK4tBB7htzmY4iuBh4EfmKxO7cT3ZRzQrcCGZ4PbtMjY+F9X6F
         I1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=raE0bEyLLL3+Nq2kPEBUvBEq7TdRxkLowLoERhJ9/Ac=;
        b=ac+koLDfnMKvmMZo5klIzh91CSRnReyV0N5mgy0RdV8xN/lTcERAwIehgNPBjzWnnf
         Ye4RTi0BBujHVK90wVq4zJKoh7HevWux5VmTCLQCzPOlhZDf5y3Wk2fwZ7elgktpCBn8
         AN/IhkVfA6ofyUpjNsGinW1FicWL3X8C7HCUsVlrsdrD4pXkx2538d9qiFU9oE7s2bwW
         0dC3C+fPtmAoX/wVDK0ywmrUkXkQdkv3kbMEiPcktmiMLA7MAI29gx5BX51WClxI7Yc9
         OPKYygChfjMRaPA03zXvb2O5TZxRvsKHXnlOnOvurA4LaKvTaMpBdtvyId7e8qsmYPV7
         LiNg==
X-Gm-Message-State: AOAM532mRX7vm9XmUQeZh6/VjG9/bwRYjTM+ID6D45ISencw7YYd6V2y
        Ij/PzGxuBFfLlWVTvUVGqhk0bAh1XJ0=
X-Google-Smtp-Source: ABdhPJylimLPFeCw/3olzjnbEWukIrSVtmnYWzIPX5QeLtip0hXYqhF1Yy1lQuPu1et4DZlwcufWtg==
X-Received: by 2002:a05:651c:382:: with SMTP id e2mr2641870ljp.401.1631755786180;
        Wed, 15 Sep 2021 18:29:46 -0700 (PDT)
Received: from [192.168.2.145] (94-29-62-67.dynamic.spd-mgts.ru. [94.29.62.67])
        by smtp.googlemail.com with ESMTPSA id p4sm184969ljc.135.2021.09.15.18.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 18:29:45 -0700 (PDT)
Subject: Re: [PATCH v1 2/4] PM / devfreq: Add devm_devfreq_add_governor()
To:     Chanwoo Choi <cwchoi00@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210912184458.17995-1-digetx@gmail.com>
 <20210912184458.17995-3-digetx@gmail.com>
 <329a691d-010f-ca2a-22ef-929fb4495ce7@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <535c8517-b983-29d8-6b06-bffe4243aec1@gmail.com>
Date:   Thu, 16 Sep 2021 04:29:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <329a691d-010f-ca2a-22ef-929fb4495ce7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

15.09.2021 21:37, Chanwoo Choi пишет:
> Hi,
> 
> There is ordering dependency between devfreq device and devfreq
> governor. Theoretically, devfreq governor must be released after
> released of devfreq device.
> 
> devm_* support the release ordering by the sequence of registration
> in probe()?

Yes, the release order is always opposite to the registration order.
