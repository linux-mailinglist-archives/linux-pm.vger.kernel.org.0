Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968A5578994
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jul 2022 20:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbiGRS3m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jul 2022 14:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbiGRS3k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2022 14:29:40 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59391FCF9
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 11:29:39 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id i206so22406327ybc.5
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 11:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g0Bc7l5criB4x7LkOzVEj1BOEM3pqGkDt4Vacsn1cYU=;
        b=qPoIADPYfzfhWv/vheJIExgWZ+udnNLpcwzuBsdbrTmYMLTUTsFM01/Wvgxw2tLOdg
         A126oIUEWixMoQG8n9Ym8i+2rIre0Tpd65fcWaTkNeDXf3O9vJhHVplBDWd5jm9ZutPm
         YeXUP7o5+M5Jc9aqpyQ6z9GqYbmuuITgdAxXlfWhO6Dlc8xFg+htiMTAf2T3tSd/Fyui
         VCgBejYgJhhh435OMpX6EI4F87PlFNWxRUHRNPvoIANf7qnTPJx4pqWSitaHzcKQRDpy
         3fo9hpYgSoP2nDdKnlnjdeHydLz5Pi+OfigLZFpWE50w3DAXUHVezDloo6w4s/1C19vh
         yNPw==
X-Gm-Message-State: AJIora+oRFo6KoIxN+zuTpjfXRViWPc2LQurheM7uFQPXJhfV3JHL1Yk
        Q/qnMVok7EkSpzbgYUDLpTP5QXO0poCY/Sk+s2WBe/FP
X-Google-Smtp-Source: AGRyM1vpxcb0uzPycpJXUCRiNElC9SaY08GPh0rTa96bBGgNMx60k5c9ui/swz00QbT456jXtY7Vj1P8nfUZs4lvsYc=
X-Received: by 2002:a25:a2ca:0:b0:66e:719e:279 with SMTP id
 c10-20020a25a2ca000000b0066e719e0279mr26712613ybn.622.1658168978906; Mon, 18
 Jul 2022 11:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220715045936.xsrxduwit4beijzi@vireshk-i7> <CAJZ5v0ioZCPLXOOFxeNOV_OKHS1fe-foaSkVj+Ta_u+j9mS=YQ@mail.gmail.com>
 <20220718014132.uammson5fsnr2ri2@vireshk-i7>
In-Reply-To: <20220718014132.uammson5fsnr2ri2@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Jul 2022 20:29:22 +0200
Message-ID: <CAJZ5v0jVFrK+Z=pfVohAfJDC2OmwNqQ-neMAaChkTt-M2Quh4g@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm fixes for 5.19-rc7
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 18, 2022 at 3:41 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 15-07-22, 14:00, Rafael J. Wysocki wrote:
> > Pulled and pushed out, but I would appreciate getting pull requests
> > somewhat earlier before the -rc I'm supposed to be pushing them for.
>
> Yeah, that's what I try too. But this time the patch itself came in on
> July 13th and I sent the pull request on July 15th.
>
> I mentioned -rc7 as that was the next rc in line, but it was actually
> fine for this to be applied after rc7 too, before the 5.19 release
> though. Should I send the pull request (and tag) without mentioning
> the rc number in future ?

It definitely helps to indicate that it is a "fixes" one that should
be pushed for one of the upcoming -rcs, so I'm not sure.

Perhaps, if you say "-rc7" it is better to mention that -rc8 or later
will work too.
