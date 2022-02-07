Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658254AB910
	for <lists+linux-pm@lfdr.de>; Mon,  7 Feb 2022 11:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiBGKtJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Feb 2022 05:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355402AbiBGKmG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Feb 2022 05:42:06 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFEAC0401CB
        for <linux-pm@vger.kernel.org>; Mon,  7 Feb 2022 02:41:42 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h6so5186034wrb.9
        for <linux-pm@vger.kernel.org>; Mon, 07 Feb 2022 02:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T6Y4XwyMFlMeGLzQGb5LndPQ3ElLUnlBrYaGjIYGShI=;
        b=Ob5A1YIBRvULbvGmzFBCbIcU+XZeq0qU4VD1yGb6jrOI1GIR0OoVYDmZn72ar9cIbu
         NcurQVPHxzzlFAcNcArrPQ+lUEswI0+Oy2u+WOwKC53DivxIPFfUKXnCLVx6Hg8OGM/z
         JLao0lZFOY1L1Ym/Ns6uHfIoe3i/x+xpDrYqDI5edmYQXBFzgHNSTB4HW8wGJIrG+b8q
         3VHcP5bT7cjR/UAOxs2bpqJrsjr4oYYR//2wqdsva4lHNYxMMPTz5cEdya5UWFJFxxSU
         zadQp+mOo4RRnaQHLKM0jQAPoapwYr+nkZrButpeQNj8qnmt3x56dyfwioAcY/X8k0ZP
         iSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T6Y4XwyMFlMeGLzQGb5LndPQ3ElLUnlBrYaGjIYGShI=;
        b=dTTjpTbXX7BaVUjUy+NthsE24tSW9MkqlzuF3If7i/Pb8eQW30aKZC69mbKh1BsvjN
         aQAtlNdXp6514Bn43z5FKoahKXva7iBfGLbDxve38QO30Vtdz7ga5e4C3ICrATUFB9nv
         +Ds0kPVX6F8kptXmDbZdyJ51dL0Sl9YNsjrvpO5mgLtgerMgv5fKxTeC63reOuRzfZVf
         bnO2Az4mn7su8KHBwbz8C+NYo3NGeQiDZ9EI1L6+QHEoUwFTSXx9ZdIgcAN5n6HSHS+q
         F8QKJRqMtM9WkYAMLkwBegec3t/0zj/QVYmX2rFDEZk2EN7X1Ox4y0UKE0ixfseZgW5c
         A7Ng==
X-Gm-Message-State: AOAM533IFz5DKX2xg6YQcgIzX8PmIof1yG+q7Y7718N33pXlOp7MbL/H
        t4dGZet4W2h/n/42wZp/nOXU7w==
X-Google-Smtp-Source: ABdhPJwYXiJDItEqRFFJ0jxOt0InTlKSm5WeIpAG+Cbkr0EGULbWjnWSGTHjnC6+X5lO/QPTRJ52iw==
X-Received: by 2002:adf:dd8e:: with SMTP id x14mr1125270wrl.576.1644230501325;
        Mon, 07 Feb 2022 02:41:41 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:aad:d73a:87d6:4855? ([2a01:e34:ed2f:f020:aad:d73a:87d6:4855])
        by smtp.googlemail.com with ESMTPSA id ay29sm8852796wmb.38.2022.02.07.02.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 02:41:40 -0800 (PST)
Message-ID: <0d2217e0-44f7-8587-3e1f-a73d301ab166@linaro.org>
Date:   Mon, 7 Feb 2022 11:41:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/2] Ignore Energy Model with abstract scale in IPA and
 DTPM
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     amit.kachhap@gmail.com, viresh.kumar@linaro.org, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com
References: <20220207073036.14901-1-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220207073036.14901-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/02/2022 08:30, Lukasz Luba wrote:
> Hi all,
> 
> The Energy Model supports abstract scale power values. This might cause
> issues for some mechanisms like thermal governor IPA or DTPM, which
> expect that all devices provide sane power values. This patch set prevents
> from registering such devices for IPA and DTPM.


Does it mean for example big and little have both 0-100 ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
