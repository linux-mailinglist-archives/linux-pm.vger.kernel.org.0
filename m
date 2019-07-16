Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C41456AD9A
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 19:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388172AbfGPRZK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 13:25:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44036 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730499AbfGPRZK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 13:25:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6176F61795; Tue, 16 Jul 2019 17:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563297909;
        bh=E5p7Z6jiwg8b3RG8QEidSAHm0UK6r/RsYJx8TtIg3d0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YMAO/Lzmpbh+W3W0jOwTwxQ/vBTA2C4osuIh5yDdtr7a5fIogBY0piCB1hBPhi36K
         QShXDhzh4X7SdBUYpCILyQHlocIJFZ6KSB3mMp7tLhStCmwaAZ7J/Swlsrw8CvJ2JK
         T134CtyvgbzjH7z13AE8W7S8RzBj4RDdgTDqeg+0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.79.43.230] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 87FF4607DF;
        Tue, 16 Jul 2019 17:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563297908;
        bh=E5p7Z6jiwg8b3RG8QEidSAHm0UK6r/RsYJx8TtIg3d0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WH2V7EaISChprSpgmnENhb7djJr8oqh3IZfE2Zmnz1iSHV0zOS6odeq7pyHjSPOO/
         +Ox8zggGM42hFlNU0Ckj2HNcwZf9MtB2CFSkZuWOGBn1tzlSw3e66DxN7+iYG7JgEi
         CXapIlUYfiJQSVA+EpBJorC4ra9Q32obxqbhU76k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87FF4607DF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v3 1/6] dt-bindings: opp: Introduce opp-peak-KBps and
 opp-avg-KBps bindings
To:     Saravana Kannan <saravanak@google.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190703011020.151615-1-saravanak@google.com>
 <20190703011020.151615-2-saravanak@google.com>
From:   Sibi Sankar <sibis@codeaurora.org>
Message-ID: <98b2e315-e8da-80ad-1ef8-e6b222c1c6fe@codeaurora.org>
Date:   Tue, 16 Jul 2019 22:55:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190703011020.151615-2-saravanak@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Saravana,

https://patchwork.kernel.org/patch/10850815/
There was already a discussion ^^ on how bandwidth bindings were to be
named.

On 7/3/19 6:40 AM, Saravana Kannan wrote:
> Interconnects often quantify their performance points in terms of
> bandwidth. So, add opp-peak-KBps (required) and opp-avg-KBps (optional) to
> allow specifying Bandwidth OPP tables in DT.
> 
> opp-peak-KBps is a required property that replace opp-hz for Bandwidth OPP
> tables.
> 
> opp-avg-KBps is an optional property that can be used in Bandwidth OPP
> tables.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>   Documentation/devicetree/bindings/opp/opp.txt | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 76b6c79604a5..c869e87caa2a 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -83,9 +83,14 @@ properties.
>   
>   Required properties:
>   - opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. This is a
> -  required property for all device nodes but devices like power domains. The
> -  power domain nodes must have another (implementation dependent) property which
> -  uniquely identifies the OPP nodes.
> +  required property for all device nodes but for devices like power domains or
> +  bandwidth opp tables. The power domain nodes must have another (implementation
> +  dependent) property which uniquely identifies the OPP nodes. The interconnect
> +  opps are required to have the opp-peak-bw property.
> +
> +- opp-peak-KBps: Peak bandwidth in kilobytes per second, expressed as a 32-bit
> +  big-endian integer. This is a required property for all devices that don't
> +  have opp-hz. For example, bandwidth OPP tables for interconnect paths.
>   
>   Optional properties:
>   - opp-microvolt: voltage in micro Volts.
> @@ -132,6 +137,10 @@ Optional properties:
>   - opp-level: A value representing the performance level of the device,
>     expressed as a 32-bit integer.
>   
> +- opp-avg-KBps: Average bandwidth in kilobytes per second, expressed as a
> +  32-bit big-endian integer. This property is only meaningful in OPP tables
> +  where opp-peak-KBps is present.
> +
>   - clock-latency-ns: Specifies the maximum possible transition latency (in
>     nanoseconds) for switching to this OPP from any other OPP.
>   
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
