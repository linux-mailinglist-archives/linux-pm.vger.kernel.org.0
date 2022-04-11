Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBFA4FB1F7
	for <lists+linux-pm@lfdr.de>; Mon, 11 Apr 2022 04:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243745AbiDKCvc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Apr 2022 22:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239189AbiDKCvb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Apr 2022 22:51:31 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6865C38BB
        for <linux-pm@vger.kernel.org>; Sun, 10 Apr 2022 19:49:18 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c12-20020a17090a020c00b001cba1ebb20cso660116pjc.0
        for <linux-pm@vger.kernel.org>; Sun, 10 Apr 2022 19:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uXcIee9Yns7jOLzfV/llZix6Uxz5Viuskna/6ugB7Mw=;
        b=OD6rDXon45iZxMJDeZEO1PIWGEgxz7KmR0yEBJz5VUeRxfm9uUtDlzKbAL7iXtXjqA
         glo78+MtNXTUC983V2TiNtUs9HqNcSaHfqO3QAtgv9hDZJvqQqc1hE2uFzUCJtSWcECh
         /uw7o9idEqb7L94kNlgf0LFTDZdrwcufkxTLGP9WXxY0DyqnY3WVds3fzHiFCKhNDXFe
         ehf/KykXIA9mzy2wihmullxcP/LBPcEPW2RQrErUCldd7aFY4BLpn7sXOj0boqc4KAnn
         7LJe9ugK/ELoXgykQHl493EZzDijYZT8v0/rmM1pVgOMFD/ae+S37a6WhPaaLsYKj9Z7
         4nfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uXcIee9Yns7jOLzfV/llZix6Uxz5Viuskna/6ugB7Mw=;
        b=PYmIjLYRDB2k0/bwKkyAFnPVti+YR0oajjppKgl7mdY2XAgFul6UK2cTQm9N7rV5/c
         LlR/QYz/al9RoFynkkySXSctOytQESgs5Ry+I2kek7mT5xC24fiUNTbrhYym4zk2WfTf
         G8tXSePNkGtB9sOZf7+SMVgSuJd/dGN7lcpXXdcf1fA8G2Lzs9ReN/JOEMAJdV8VOfgh
         G9JkGRHUICS84JnS/55Ex96H4e2zvyVdfJw0S6rzTu8g3w+yzQMHE9ZeMQixYWHFLzi/
         jN6/sGPFnVA5mfUM6AYqGM5r62EHJrIq0uC/i8lEKruzLwBp69otChZBuKn++dHM/vt3
         J9RQ==
X-Gm-Message-State: AOAM533qrQw2SDNPOD7mgS8NWuDShfTmBzes0RJKsuz7yR+vz+4gK2Sh
        cSnutM8E426MpKBzuxhPUisjOA==
X-Google-Smtp-Source: ABdhPJwiHW7XNh4KwMT8iJrViqSNRE5fm/cebUjnrBUONKKP70zUxuBBAP4I6t2IGX5tnm/+eN4DcA==
X-Received: by 2002:a17:90a:3d02:b0:1ca:7f92:1bf1 with SMTP id h2-20020a17090a3d0200b001ca7f921bf1mr34536653pjc.177.1649645357878;
        Sun, 10 Apr 2022 19:49:17 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id i7-20020a628707000000b004fa6eb33b02sm32511957pfe.49.2022.04.10.19.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 19:49:17 -0700 (PDT)
Date:   Mon, 11 Apr 2022 08:19:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PM: opp: Fix NULL pointer exception on a v2 table
 combined with v1 opps
Message-ID: <20220411024915.7zmoyphgongzorci@vireshk-i7>
References: <20220404123757.798917-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404123757.798917-1-krzysztof.kozlowski@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-04-22, 14:37, Krzysztof Kozlowski wrote:
> dev_pm_opp_add() adds a v1 OPP.

That's not correct, it adds a simpler version of OPP and doesn't
support complex types. A opp v2 table with just freq and voltage
should be supported by dev_pm_opp_add() and we shouldn't disallow it.

I think all we need here is a couple of checks to make sure the
earlier OPPs don't have anything which the new OPP can't support. For
example checking required-opps field, etc.

-- 
viresh
