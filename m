Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBE26A6B21
	for <lists+linux-pm@lfdr.de>; Wed,  1 Mar 2023 11:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjCAKzz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Mar 2023 05:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCAKzz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2023 05:55:55 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D4136FEC
        for <linux-pm@vger.kernel.org>; Wed,  1 Mar 2023 02:55:52 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id ck15so52317367edb.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Mar 2023 02:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8saexLl0iDACivCdxtyIVMr2nPQP2/Z6XPpVe9xyI0s=;
        b=Kf1Zqmkl4ZOzYXWzSgMj/Nx/P66zdBY24oBxpfp31lK1+P5DeF8b3EARtb6SZRPLSZ
         5ag25fDMVVDYeM5CqHsWMOC+MN3degj+8/BENMSZYvCpbiXaAwtEg1uujDVmlsl6AyvA
         mp9Qo8DHZr/utC2SW4Hgp6T8pNQzajjwq0iqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8saexLl0iDACivCdxtyIVMr2nPQP2/Z6XPpVe9xyI0s=;
        b=dpQMeNRYlmrqm0zhOqp+fjI/T7FmvCMgJKT38j4GK8+pg00Orm5LicIGZlEKIcdTZJ
         KCidic5yw5xrr10eERM4aajni9DI+Co6pT8TnVfv03UFgxATuvZbm6ePoh0ygtCE7thT
         MUEfL0qOJkafXrDPHExCKDIZQkRo1wHGfd4ZqT7Z84Tp5W5RRh7VDhTGNIWCM2SiGPTG
         21x5Q2px+6rWYm1XxSq0Ylb8jI2COFwU1nWWowyyIugxgFqeA2WidlS7XF8g6nan5sT9
         I/RHTyuiv4JvdNJW9OSwGdS90uGDMFueoza8lJ66iZ66oZA3kJa88c/LFHhxx7Q1Rm8e
         Qc4Q==
X-Gm-Message-State: AO0yUKVAMGLVH6frZJzvHSxf5IRb4s0JVDM1XkYSNpeVULoatoZMxiWG
        MM/xIsVO7mv9USSZm0NfcrLjKDaBZvv9BsWmEmM=
X-Google-Smtp-Source: AK7set81dkGfQhV/AfHdxlP3XAwwYdsOxcL4NjuxBoSuefali5c30HhwrceP/MnDb4rb0A/m21S8Pg==
X-Received: by 2002:a17:906:770d:b0:8aa:c038:c768 with SMTP id q13-20020a170906770d00b008aac038c768mr6899603ejm.66.1677668150826;
        Wed, 01 Mar 2023 02:55:50 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id k15-20020a170906a38f00b008ef42f9cf48sm5514433ejz.82.2023.03.01.02.55.49
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 02:55:50 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id ec43so52049782edb.8
        for <linux-pm@vger.kernel.org>; Wed, 01 Mar 2023 02:55:49 -0800 (PST)
X-Received: by 2002:a17:906:d82:b0:87b:db55:4887 with SMTP id
 m2-20020a1709060d8200b0087bdb554887mr2884548eji.4.1677668149030; Wed, 01 Mar
 2023 02:55:49 -0800 (PST)
MIME-Version: 1.0
References: <20230227121318.2116638-1-md@chromium.org> <ae60774a-63ba-e4ab-b434-d3c38cb897e2@suse.com>
 <CAPxDTA8BQDL1hrRRyUjCes77mQ926206i00q1nCEo55RB2CRzQ@mail.gmail.com> <545bb6c8-8c5d-6553-469a-99c1f4245b0a@suse.com>
In-Reply-To: <545bb6c8-8c5d-6553-469a-99c1f4245b0a@suse.com>
From:   Michal Dubiel <md@chromium.org>
Date:   Wed, 1 Mar 2023 11:55:37 +0100
X-Gmail-Original-Message-ID: <CAPxDTA8_gZU+Qi_xFNfQUQTVTgRt+oEFXHVhAodt-bCPU3g_bA@mail.gmail.com>
Message-ID: <CAPxDTA8_gZU+Qi_xFNfQUQTVTgRt+oEFXHVhAodt-bCPU3g_bA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Suppress warning on resume attempt of explicitly
 frozen processes
To:     Oliver Neukum <oneukum@suse.com>
Cc:     linux-pm@vger.kernel.org, rafael@kernel.org, pavel@ucw.cz
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 28, 2023 at 1:07 PM Oliver Neukum <oneukum@suse.com> wrote:
>
>
>
> On 28.02.23 11:11, Michal Dubiel wrote:
> > On Mon, Feb 27, 2023 at 4:19 PM Oliver Neukum <oneukum@suse.com> wrote:
>
> >> Isn't the core issue here that processes frozen from user space and
> >> tasks frozen due to a PM transition are not in the same state?
> >> That is instead of inventing substates for a specific state you
> >> should have a new state?
> >
> > Please correct me if I misunderstood your comment. I believe that
> > effectively we already have a separate states for task freezing due to
> > PM transition and due to userspace requests and the kernel is able to
> > differentiate between the two (e.g. there is cgroup_freezing()
> > function to check for that).
>
> Correct. Hence there should be two states also formally.

Do you suggest introducing another TASK_* define for task_struct's
__state field, which would differentiate between userspace and pm
transition initiated freezes?

Currently, the cgroup freezing state is encapsulated in kernel/cgroup/
sources. I believe it is right to keep the cgroup state internals
there, and expose only an interface like cgroup_freezing() to other
modules. This is what the freezing() function from freezer.h does. it
checks cgroup_freezing() and other reasons like pm_freezing to return
information whether a task is freezing or not. I've only extended that
a bit to have an option to get information about the reason causing
the freezing in addition to a boolean freezing/not freezing info
existing currently.

Regards,
Michal
