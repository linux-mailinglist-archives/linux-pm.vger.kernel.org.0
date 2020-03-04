Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2DD1794F7
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 17:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgCDQXu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 11:23:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52039 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbgCDQXt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 11:23:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id a132so2793314wme.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2020 08:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yu7TBohBFammMQ5U/37U59+ZpffYPceErIyYR5cHG6k=;
        b=TLyB/QQ9ZmH1ttGlz0a7M3nm1X36N/X7Q4JndefBnOcB6IF7GUFFIBrLroP8ig8oUz
         p/FxWDAKuoEBQ7/HqylO/Ox8KNc+g37oqLdj7lJmADzxxP4egp36hg8IgWPJQNojhwnQ
         hM2appY+mFTN4/2F9VBqmK7924+K+ejDSB+yHVWyJYJ1HNK7yCBpbf8DD8QRLXlGAdOS
         jUDgjDm7jeKMN4M/I58pm5KzhCeoYK79Fen0t5EFmnWM/7lBNgs5cLEXR/CeCH+g+v1T
         pohzcT6sZM5spG+rPqhmQu7WYoswW/+pbB/N27q+kYqqFjMF+TXt0xeS/FYrAnDDVjOO
         PXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yu7TBohBFammMQ5U/37U59+ZpffYPceErIyYR5cHG6k=;
        b=foMeqEFgv2KNLjfgCvr+nSeHqvuye4Ekz+m4lBcM7N04qW1dlQXh6OaRtCmW7vEV4Z
         epdxsyrspAZc2bqr3LpEUV+Qa04HJ7Tt1bTXL1JriNtNzY9oXVkyL8WsP26TGNqLx8YZ
         2eB8h7eKi6+cP3wfSak4RcyNEvjPbkLEM8964STEJP6FYsShd9Ecv+ridd9Qqtuv+La6
         cDDxVmcwskURxolqB9wQoPM3GL9gUVKgfaHI5mrnHjzd/pbYIsvFwOm/dbvRo0WscdQF
         owCFirpj39eji9T9hgltrmCTWnXPyLlPZ+m5OwMeyy6PZ6UozKoahnq1mY/R0PEoOA1j
         kp5g==
X-Gm-Message-State: ANhLgQ3zQTLkcZIjQ4YKJA7gc9ZaHlh1jrDZvczK1TWIdKJ4g3FZrHrs
        eaGZD+e4Jjvua5MKvm7xIOTK0zkF/rc=
X-Google-Smtp-Source: ADFU+vumRIGwm+zI4SodqbfNIiAqd5CjMCV6Qxs6+MTISOeydrYmXPLaAQ9OPIqlHsDCVZpY9AdvPQ==
X-Received: by 2002:a7b:ca55:: with SMTP id m21mr4386951wml.162.1583339026096;
        Wed, 04 Mar 2020 08:23:46 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id b7sm39020656wrs.97.2020.03.04.08.23.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2020 08:23:45 -0800 (PST)
Subject: Re: [PATCH v3 0/6] Split SDM845 interconnect nodes and consolidate
 RPMh support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>, robh+dt@kernel.org,
        evgreen@chromium.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mark.rutland@arm.com,
        daidavid1@codeaurora.org, saravanak@google.com, mka@chromium.org,
        linux-pm@vger.kernel.org
References: <20200209183411.17195-1-sibis@codeaurora.org>
 <20200225051645.GX3948@builder>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <2f8560a4-7879-0b6f-475e-c7d5edbbd645@linaro.org>
Date:   Wed, 4 Mar 2020 18:23:43 +0200
MIME-Version: 1.0
In-Reply-To: <20200225051645.GX3948@builder>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/25/20 07:16, Bjorn Andersson wrote:
> On Sun 09 Feb 10:34 PST 2020, Sibi Sankar wrote:
> 
> Hi Georgi,
> 
> Will you pick up the bindings and driver patches for v5.7? So that I can
> apply the dts patches.
> 

Hi Bjorn,

Yes, please apply the dts patch with my Ack.

Thanks,
Georgi
