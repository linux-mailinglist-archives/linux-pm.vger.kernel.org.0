Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E4D7BF8CB
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 12:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjJJKja (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 06:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjJJKj3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 06:39:29 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98A794
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 03:39:28 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a7c7262d5eso2867977b3.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 03:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696934368; x=1697539168; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AON3B4seSEhxkWjEX7unQ5KNMoc19fAbwi1Czfw9Qbg=;
        b=m8wa1KezU9B3Mexh8dz8EbXPGWwru+SKPzCJISO3e4OFYKAJZslwENdembRSTSNiJk
         9zwQs5UeXx6xCeEfLpWyz+jdHqrzhaWn5H45A8ald79NiQjd0tHSVQq0leirmYxvfO7C
         TeCo8MGlEydOxmzR4TBzabwCU/cf3FJz9J0lIyqMWIWHYO2hIfh4GAG4U1OPvgEKHWXu
         pej54IUygQE53yj+fmihCxObyrfFu4Qp6Hrn8Xh15bJH3RgaG6nqtxhq4yzP6nNcYOnT
         IaZsOwoe6ygVChFZk7L0I5iWFk+ygOYmtuhiEB75HyHd+oFIcEG+2ilyG9m9+l7fn2BI
         qaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696934368; x=1697539168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AON3B4seSEhxkWjEX7unQ5KNMoc19fAbwi1Czfw9Qbg=;
        b=w4tFu6xTpElZaeGuD+GQxA/VxsGCXHpnpmqGk1a+GqfDKkLuIPlV1PKk0zslQnTfhU
         tJptjTQYNtJSwiqUI3sM8MRVoiUsFfcJ+N889Y1EsRjcRJqFUwxzP/+1+5Ec6Qg5i1e5
         dvlyllaefzxf6yKQ6wh0k1J3vC0hXxt1orcf31VmiC/yeF+WON6btXFrEBoDanvbGxHe
         kJBtdzjsGFIv5jFwZzbcqCkl7Lth686jH+lOcoB1Yh8kCMGtUEduaIiIEIffbDxp23EI
         yNuGOALis8heL1+GId62JzJgP0RCllic9vpgVBeXKr/gFzRnc3ov4fDiueUFrDCewZOa
         +yVQ==
X-Gm-Message-State: AOJu0YymiI14sq+Um0hKf0LkFiYtw83eOgMuGfCUTU/BJkgm/vVQzZdT
        adssvup0Y4IbS9su6gzoc7pV1cNSSkFsQviwWi6Urbdgp3IeEt8s
X-Google-Smtp-Source: AGHT+IEsOYp9m7gxuuDRihnJxYI8XUBZJQV+tJxLGScemu2bdLtzHOx6raXzITWaUQgTdIU50KSqVtdZbyvsQW87fdc=
X-Received: by 2002:a5b:3d0:0:b0:d7b:ac56:493b with SMTP id
 t16-20020a5b03d0000000b00d7bac56493bmr15500919ybp.7.1696934368057; Tue, 10
 Oct 2023 03:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <DU0PR04MB9417DE145496DC03579F50E488CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417DE145496DC03579F50E488CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Oct 2023 12:38:51 +0200
Message-ID: <CAPDyKFqAackXJyrVNK2DtaTEWNju=xE9Dmec8AGqTqTZS7wi0A@mail.gmail.com>
Subject: Re: Question regarding scmi_perf_domain.c
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 10 Oct 2023 at 12:30, Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi Ulf,
>
> I just see you wrote scmi_perf_domain.c, just wonder this driver is only
> for devices, not support arm cores, right?
>
> For ARM cores, we still need scmi_cpufreq.c for performance settings,
> right?

Yes, correct!

Although we may want to switch the scmi_cpufreq to use the SCMI
performance domain too. I plan to have a closer look at this, to see
if it really makes sense or not.

Kind regards
Uffe
