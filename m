Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3887AA02E
	for <lists+linux-pm@lfdr.de>; Thu, 21 Sep 2023 22:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjIUUdm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Sep 2023 16:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjIUUdM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 16:33:12 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976AD88AC4
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:39:15 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-350fbd09d8bso4239605ab.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695317955; x=1695922755; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g7keM3Y6fMhMfFMuWtMa5jx/7Kzyqu5FnvjTMxZXwko=;
        b=loFTCy1B5Cxmj3czPIxvSEfmCs6HQj6R6+Dx13DTyLpkbRuuTcltfN+bKit6dPTS7S
         iA6vzTrNTqscA6VMS2rqXhgnfN9DuJZ7nep9m0/HqO3IaGRYfZTur4/+DQQNlj0ssOaw
         x55QY/EBczhym6MobLWXro+Q9iVQ1DDFCyy1NL9XCuc/pX1/c81Ebz1qELDnWvA0YKVm
         ylX4rvJRN40ZHgy6ciWMjkNCUD+9r5hFV25qWn2Njq+PcwCbFtOs3V+hqnHj8jnFL7NG
         2W6dtOUyKIQs/1vYSn4+tffd5ytw+pciecxTi+B12a77KE5ZwW8Ihzj4HovgmZTTkqfX
         7sEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317955; x=1695922755;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7keM3Y6fMhMfFMuWtMa5jx/7Kzyqu5FnvjTMxZXwko=;
        b=eWIufhTG0Qb65UPzvw75IM3Xyf/hTq36+KwJSyeQhHEirDlOarpI5ReQnv1oA+k2uv
         YxzyGGH6ChqI8kVN/4vgxAocu5q+E9VKC9TwvK+5qA8D7HQcRFPpFexrtMRq4XY7tg2f
         bzMBd1pgB0uZpADrX0akLmiIsjAElDtGQhRjQxYxyGVBhTbN40uZzZHnMopshO01oX5B
         hLa5q+Ni0aHxrzStvS+Rjsn8cndSyjNGMByVkJ6Mg4386+m1JhghtyVaGk4OvSQNq4iA
         s2Oswj68L95aMRBSGeJndY8O3dJiQqoQd8Ef4U3vnb9hgGhqfMXQ4/gS0Pozj01xHPv+
         CWTQ==
X-Gm-Message-State: AOJu0Yy+8eOObVl/fctj/JmWA7iDjTCWgcTfd/QpWXAnskW9PhWxvg3a
        sUpCskB5sq3lgljZqrW05CYs5Hxm9wFifalPxwndccpHA+Ez7FTO35I=
X-Google-Smtp-Source: AGHT+IGFiuq2yAavaGohC3doXrEfCSrTTz4ql7Ccof0B/BskF92xcU/mBMfs+tpyTmR+iHwFXILbeDL6YKk4w7qSnnY=
X-Received: by 2002:a25:8201:0:b0:d78:20d6:6f4e with SMTP id
 q1-20020a258201000000b00d7820d66f4emr5008759ybk.38.1695302610815; Thu, 21 Sep
 2023 06:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
 <20230825112633.236607-9-ulf.hansson@linaro.org> <20230921111110.tbffr5sik3ycw7gf@bogus>
In-Reply-To: <20230921111110.tbffr5sik3ycw7gf@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Sep 2023 15:22:54 +0200
Message-ID: <CAPDyKFrSkgSee=8zruR65TALvAj+hcWw1CaUOUwD3EpdxymtBg@mail.gmail.com>
Subject: Re: [PATCH v3 08/13] dt-bindings: arm: cpus: Add a power-domain-name
 for a performance-domain
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 21 Sept 2023 at 13:11, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Aug 25, 2023 at 01:26:28PM +0200, Ulf Hansson wrote:
> > When an CPU's performance domain is managed through the SCMI firmware,
> > let's enable us describe this as a consumer of a power-domain provider,
> > which is the de-facto standard to use for performance domains. In this
> > case, let's specify a corresponding power-domain-name, to point out the
> > corresponding index for it.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > Cc: Conor Dooley <conor+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v3:
> >       - New patch.
>
> This patch and 10/13 are quite generic. I am happy to take it as part of
> this series but just thought of checking again if that is what you prefer ?

Yes please, go ahead and pick this up through your scmi tree.

Kind regards
Uffe
