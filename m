Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E117EBD0C
	for <lists+linux-pm@lfdr.de>; Wed, 15 Nov 2023 07:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbjKOG1s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Nov 2023 01:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbjKOG1s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2023 01:27:48 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42861CE
        for <linux-pm@vger.kernel.org>; Tue, 14 Nov 2023 22:27:44 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2809a824bbbso152436a91.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Nov 2023 22:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700029664; x=1700634464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AKSOBVjj+YjOcXAU8cJCuporBoTYiy5nHyba5GnlAqQ=;
        b=agaLieDSj7L8eCTTz775oRhZLMFY0SzOJ7NAh1P1ga0w8nx2UIh3SY3BBeZ4Es35aE
         Hek8wiRKc+DazloKR1aW1NQNcTG2x5LSZhKpiJElFlryujlvZ2GUcrIWLoQ2EmbyHsaB
         2XHstflom80TWlZSJbT710fih6XDJNyKIQPAf628p74zaGE6zW/v+234mp0hOaEwMp8o
         +KLALvnP4txEw4OyoRrpsRqqGPhQkTi9q4rFZQOtFzAQufJ6QXdrbmK7m388W6HBltno
         AawqUFSQ0CaflKFE5/AAaJF9uHrVsmfebP2DNRsFRWCtleu7joCImd+hT0CqF4FAWU6S
         G+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700029664; x=1700634464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKSOBVjj+YjOcXAU8cJCuporBoTYiy5nHyba5GnlAqQ=;
        b=aGxZ7cTqhINEAktd4raOBdkXcQ52WtFVouMDhHE3QrQoEcOMxU/uChfT5e55lhhkj/
         L4DlPIvNoFBAq69VNHZTutc4G6PQLX60dFpIWFiuJ2GujIxm53vWDlP0BUSvwKaeUYco
         BLd3UAyTKkPNVXAFtGbLHyADgUzjNOTDtz639cTHYPXfIbDVXjiJ5WfFtJ4gLPH2tb/5
         +uM0A4YAe2trMPXhSW4zx4FHPEF86NsXxbedtDpksuLjdbArKTRMIB1SpXgmp6CckmxV
         Q7GngAA6MBxGI411pRhx+LD/f8GVk68NWaAHJXOmE29RuAC4wnLQRSZmJlr68/p+n986
         XAsQ==
X-Gm-Message-State: AOJu0YyXuV3JlLcQRtVM0k3U5aiP+ptD9EADW7csrTf/+OQ7oYzpWq/9
        rBoluS74eU3jabgse8Ty6QE+TA==
X-Google-Smtp-Source: AGHT+IHLjecUpYnZT1aX8sOnGe785XxMzOTpOQh8BD10EBM3cElVJkFW7QBKAP+68Bxnn0Wv3wq58w==
X-Received: by 2002:a17:90b:3a8c:b0:280:2652:d41 with SMTP id om12-20020a17090b3a8c00b0028026520d41mr9717051pjb.4.1700029663650;
        Tue, 14 Nov 2023 22:27:43 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a1a1700b0027ced921e80sm8998415pjk.38.2023.11.14.22.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 22:27:43 -0800 (PST)
Date:   Wed, 15 Nov 2023 11:57:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     David Dai <davidai@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Quentin Perret <qperret@google.com>,
        Masami Hiramatsu <mhiramat@google.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Gupta Pankaj <pankaj.gupta@amd.com>,
        Mel Gorman <mgorman@suse.de>, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: add virtual cpufreq device
Message-ID: <20231115062741.v3tpm337c2lidxzr@vireshk-i7>
References: <20231111014933.1934562-1-davidai@google.com>
 <20231111014933.1934562-2-davidai@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111014933.1934562-2-davidai@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-11-23, 17:49, David Dai wrote:
> diff --git a/Documentation/devicetree/bindings/cpufreq/qemu,cpufreq-virtual.yaml b/Documentation/devicetree/bindings/cpufreq/qemu,cpufreq-virtual.yaml
> +$id: http://devicetree.org/schemas/cpufreq/qemu,cpufreq-virtual.yaml#
> +properties:
> +  compatible:
> +    const: qemu,virtual-cpufreq

Not sure why we need to mention QEMU here.. Why limit this to just QEMU ?

-- 
viresh
