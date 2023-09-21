Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3167AA4FE
	for <lists+linux-pm@lfdr.de>; Fri, 22 Sep 2023 00:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjIUW1T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Sep 2023 18:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjIUW1C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 18:27:02 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BFD36D5B
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:06:52 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6515d44b562so6444546d6.3
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695316012; x=1695920812; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C3AGJ5YqreaKjGqVvvBcJoqmWbVP9NW6r7+ZQpOUS+4=;
        b=WyNC1w4jVTj1bZMEFXt13FgWzHxeqU9qMM7KZAVq0bihoKlZxYMTtFlIkNUOiUTlPH
         wNnVAR0DwLGT6oz3qIW31RiwicTilyrTlUjum3qL9MocjpRNIydJuAyhLVbaXEOsINMT
         kPasyIcyZ3A4oSr2aYNSgf+7oiCThoWpTNU0Lke5q9fELltcJrwlR6Vj8AY+bccRUeAK
         86nENJii1wLVGb8GMm9hJzWQXj6/bSM6RHRyokGEpIliT+UekUiHO2J9EbO2mvqCk8ke
         et/btoOlr2FUZOEl3pKQLM//1t7+JZ+mDYcl0IBvpjHcpU03u2nhPu9XGkKDVIJQgnbY
         d1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316012; x=1695920812;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3AGJ5YqreaKjGqVvvBcJoqmWbVP9NW6r7+ZQpOUS+4=;
        b=HaemnAaQuERmHQT4j/vCvusmjefTB8T2HAJ7IxWycSrvtv270BlOpnHlFPRpF4k5Rz
         p3XiYQd+V7oCPrxuD9ZQkH96c92L7EMCHfY8OhtoxnNgNOKmWmhhAtb4KA2nxznQsXeR
         NqN58KQTaY7Pp9DcmOUOx1+PtNzx8p8UDiRztV0aOzulpdZodz+taczv/EkmDf+ypqq5
         E/rTtO3KVyDYUku/E9R26JOxP9Lg5VfNxRFiGE2v5uLNVxhiKxI2Op021rM0HKGbl5o/
         1AOTe6pKXRnv7coMZJzcZrVNnKRuxyFJRgyvjM/jy3s6kqjl1p69Dtq8Qcnx556rPD6x
         bM+Q==
X-Gm-Message-State: AOJu0YzK7KyhqsweMAXyQKye+w2EhdsiKyk79RPA7kzOItYbQZPulVWG
        mngJgdkOymId+i+iRh55zKh1vP0rTvi3neEC04EmrSK6lGiE6URpoW8=
X-Google-Smtp-Source: AGHT+IGxEP7M4RGeRIoS5MoOfdR/G92y7IkWBKiScp+pN2700H3k/FEmydtbEwKJZ/XQkDiYo3ii4LoHbD1J2F0GMzI=
X-Received: by 2002:a05:6902:100c:b0:d80:68d1:b826 with SMTP id
 w12-20020a056902100c00b00d8068d1b826mr6552250ybt.6.1695301553511; Thu, 21 Sep
 2023 06:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
 <20230825112633.236607-13-ulf.hansson@linaro.org> <20230921112019.gftlr5ys3yw2nwgw@bogus>
In-Reply-To: <20230921112019.gftlr5ys3yw2nwgw@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Sep 2023 15:05:17 +0200
Message-ID: <CAPDyKFpkjOFhjKMY=4dDgngi7PftE_4c+4dHE2KcGAGYnjk6-Q@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] PM: domains: Allow genpd providers to manage OPP
 tables directly by its FW
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 21 Sept 2023 at 13:20, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Aug 25, 2023 at 01:26:32PM +0200, Ulf Hansson wrote:
> > In some cases the OPP tables aren't specified in device tree, but rather
> > encoded in the FW. To allow a genpd provider to specify them dynamically
> > instead, let's add a new genpd flag, GENPD_FLAG_OPP_TABLE_FW.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v3:
> >       - None.
> >
>
> Just checking if I need Rafael's ack here or that is OK as you are
> co-maintainer ? Again asking explicitly to ensure arm-soc is happy when
> I send PR.

This should be fine for you to pick up. Rafael would have objected if
this was something that he didn't like. Moreover, there's no other
patches being queued for genpd at this moment so no worries of
conflicts.

Kind regards
Uffe
