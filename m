Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA31574D946
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jul 2023 16:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjGJOq2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jul 2023 10:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGJOq1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2023 10:46:27 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6B6114;
        Mon, 10 Jul 2023 07:46:27 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-786bb09e595so112640439f.1;
        Mon, 10 Jul 2023 07:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689000386; x=1691592386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Djg0OzyBPtk7FtAC10kjml7lVzu60E+4X9KgfmrGJY4=;
        b=Ey6VN8HdWZX6Xcj7KYt6ncxKxBVQZ7Xc9P8m9fm5CK6ugJ4I0+a1f0AsssvN7hmMqg
         Uv4WjMhaBVxy9WayVsbTKwZv9PfBJzwJoOreViu3iJMwgQP+IJuvjFoJ7ikjBCqr6q1X
         C+x0JpuL3Yu8dnX368FgdMcfCFr7Q87zXsXqlPMAylYqfNmu7sQbAMLoXJIdM2hQmKWD
         PQA4b5400QPzU/lfqluiMsMGy2TeuXgK3Ve2mitZacE8SREGhZafDlCQk2MuISbRSY7c
         0ynTFkzaR9SsiRO6pEFpBxJ0O6hr8HH66UDCmQvN7btn0iWqULopw2vZxKJ6moh+5Lit
         c1ow==
X-Gm-Message-State: ABy/qLbPnYJgxIW2GW4mJElhUFm1EUrStyu/CmZbzphpm8JL56ejPBd5
        NRAAQqWcxAIPNGpMfVRB4A==
X-Google-Smtp-Source: APBJJlGOJktui+v1wbeY1CocSq7+gx0dmzvSNlF71LrwlmZAfZYrBadKIo2SEkB/w+aQPDycxetA2Q==
X-Received: by 2002:a92:dc85:0:b0:343:9434:44f4 with SMTP id c5-20020a92dc85000000b00343943444f4mr8658212iln.7.1689000386189;
        Mon, 10 Jul 2023 07:46:26 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l15-20020a92290f000000b0033d16a45a64sm3540116ilg.14.2023.07.10.07.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 07:46:25 -0700 (PDT)
Received: (nullmailer pid 1943898 invoked by uid 1000);
        Mon, 10 Jul 2023 14:46:23 -0000
Date:   Mon, 10 Jul 2023 08:46:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: tegra: Convert to json-schema
Message-ID: <20230710144623.GA1940216-robh@kernel.org>
References: <20230707133333.2998802-1-thierry.reding@gmail.com>
 <d6386a66-4cc2-9358-e65e-b09e614800c3@linaro.org>
 <ZKwW58xHD0cGfxvM@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKwW58xHD0cGfxvM@orome>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 10, 2023 at 04:34:15PM +0200, Thierry Reding wrote:
> On Mon, Jul 10, 2023 at 10:09:18AM +0200, Krzysztof Kozlowski wrote:
> > On 07/07/2023 15:33, Thierry Reding wrote:
> [...]
> > > +          nvidia,cpu-throt-percent:
> > 
> > Missing type
> 
> Isn't this already taken care of by core/property-units.yaml? That has
> anything matching "-percent$" marked as int32-array. I suppose I could
> override this with just uint32 to narrow it further down, but I was
> under the impression that overriding standard properties this way was
> frowned upon.

The tools will complain if you add a type. You could add minimum/maximum 
properties though.

Rob
