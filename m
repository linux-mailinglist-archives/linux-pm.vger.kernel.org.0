Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53254BDC5C
	for <lists+linux-pm@lfdr.de>; Mon, 21 Feb 2022 18:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380724AbiBUQin (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Feb 2022 11:38:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380720AbiBUQin (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Feb 2022 11:38:43 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840F421E1B
        for <linux-pm@vger.kernel.org>; Mon, 21 Feb 2022 08:38:19 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id v186so35613319ybg.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Feb 2022 08:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:cc;
        bh=AT2vVSkbs5Z2AlPH3lVSxISBm4g33VFLgVGD3BjUf+w=;
        b=YJzoN4qshFdwKPIZlyC+63H94yuB8T6Cxv1EWdCMivNxTVZZGYcXbEqMmMZulq9jn6
         joN+XrqP/58RjqAGDyUPSMABz9Ck+oFzMusakGjJvlZQklbYsNSUahJp+Ijp9DBKEWjb
         KEUU7wfET2EUoX4iDuS6+9o97P1HUnW6wpWoiclPQ/mniDEvLUYO9h8Fjk+9ABDLwZ7T
         K3qwzTFy7T8J7NCTskl+deEB6dvQrU5uh5LTqZz+jDQUpTgLJUQvJH+Gb5Sun7XjTDra
         MT4oUgItVuuCETotqtz/UZ8Pri7fmnUMDr+jtH8y8rWNF0xjZ17EEN7XoGC53nze6kuk
         4NqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:cc;
        bh=AT2vVSkbs5Z2AlPH3lVSxISBm4g33VFLgVGD3BjUf+w=;
        b=TdBb3PqJ0CbsHiJrL7Ht9YEJNO3v9pdzFbfPbIqMZksKbsNzQzYF59EdVCVb7zWddw
         +5uqVDozckLoOtl3Tjxmp5LE6gmo9HI7rI9L/Z4fHo6q3mVgFaII7Cx/WTd89bGNNJsR
         iXjCW4H41dWEtlFipG20nAg7YBBH21n9HjjXI1lNbl9X1PK9ZP1dp3pGNvxgStcKuYLx
         EUrn7dUefwdwt9J3ZRrKv/+Ekr3IHG21bf8zvPxTkDGQ12sli2e/zwe+EoYGSPUfqN82
         UWvU8hWO1XicmWXxrK6O83pHVniz0IqG+HllrEt2aW1fzhWuFU0nXVPOe9wUmgetboAI
         /LsA==
X-Gm-Message-State: AOAM530nLLj06Qey5Z13k5FrcFKwLjPRz4lSL8FkXTdjj0FoWDOxb75t
        FHzndaV3qIEf7LAasc2pUzBRpZKVN+mWhT6INdc=
X-Received: by 2002:a25:a28d:0:b0:623:fa1b:3eb7 with SMTP id
 c13-20020a25a28d000000b00623fa1b3eb7mt20102653ybi.387.1645461498787; Mon, 21
 Feb 2022 08:38:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:1792:b0:211:2b27:3409 with HTTP; Mon, 21 Feb 2022
 08:38:18 -0800 (PST)
Reply-To: lisamuna2001@gmail.com
In-Reply-To: <CAOpEvtiCnodTkWRGEePkRKnENAbf_RxsrBSg9yMoHA7=dPXbCA@mail.gmail.com>
References: <CAOpEvthLrHmVZQdw7W4+Vqe_h4USWc-G2Ws=VC+yY9ugb4TY+Q@mail.gmail.com>
 <CAOpEvth3xb+Yf38vxwO+vBUEb=UMYgJJmGDt99wHSL4ok+s2rg@mail.gmail.com>
 <CAOpEvtgm8sAuFtvvMt5XwOit8PtcQstsOW2kMeKR+6mKf=mB6A@mail.gmail.com>
 <CAOpEvtikzrJj2+L9Gc=2D5-hYwc3omFfjthPKqYAGDpe_JyfFg@mail.gmail.com>
 <CAOpEvtjL_VsurSgbtQCKkajZ3U93ygArmWWf_fC78Qg9GCWJCA@mail.gmail.com>
 <CAOpEvtjE1+JEh8q6WVAu2GvfsJ=b3Wf2ML0PNwC972-0E1Rg1w@mail.gmail.com>
 <CAOpEvtgABHPkgfQkAfRZ0qAxTXDK=ozsPOrOjxKgd0UUGFAsLQ@mail.gmail.com>
 <CAOpEvtiAwxWmLYEEjK51KB1=v=guw7R2O6_OcCpKt+Pd14ZQbw@mail.gmail.com>
 <CAOpEvthcrFBPsmLGVVY_JdHPJ8QS=pNGDk5O8FP+aRNggm1o0A@mail.gmail.com>
 <CAOpEvtjWhxffsaVY+zNo4_uq-pjobfbf42jbjzo9ChB9Suz6-g@mail.gmail.com>
 <CAOpEvtiw+oH5NbwS6988mbkyXXTv2v_NOh-xnZiTY92NziRSCA@mail.gmail.com>
 <CAOpEvtgiF5WouzLNuKgfJiXgH9ZxuZk2E58UfHNpLVVkPkvLtw@mail.gmail.com>
 <CAOpEvti9jB05Ruk9S9PHqix-rgJ8FyFyncVG7J33ezi27n9hfw@mail.gmail.com>
 <CAOpEvti+c2oryNZ9FrbeioC9rv3fm+utYkRLN9OG4Kwp9aphsA@mail.gmail.com>
 <CAOpEvtgRGHb_egc1jHUwaC7ACGmeJe1AJfWOgHAi-uxO1jaGTA@mail.gmail.com>
 <CAOpEvtiYxspYn5mAWbCB3A1JzpNi6jtquSXDUJ9fSupaVFwpBQ@mail.gmail.com>
 <CAOpEvtgJxQ863PHT34CV_Jbt9kOP0+H7h90SuWWeWHtmubK2Mw@mail.gmail.com>
 <CAOpEvtgL3NF8xBoi+q3xWrjM0dbYTzc7LBH9W+QeVhd-ivs4cg@mail.gmail.com>
 <CAOpEvtgQvyZqcyvWiKAOerQ-O-PCe2+L_UUrgVAuKojQd+deeA@mail.gmail.com>
 <CAOpEvtiyc3wGH=poH_HdNa1TLTao5iGnLfS0LRQ5W_o139hpbg@mail.gmail.com>
 <CAOpEvthNcRSWE8Csit95q=3+0PCKqw=G2RKZWnRMJH7jFeTR+A@mail.gmail.com>
 <CAOpEvtgbxve2i=Ytx1Cn1n-K4f9L08_R59An+4bCwd47XvNf6w@mail.gmail.com>
 <CAOpEvthQWN0zZ6_BpmS21YS2Lpxe8vjZEctXy7Q4vnVtB9v6QQ@mail.gmail.com>
 <CAOpEvtjqR98reFbTHZR=oc85zNEb0=u+Vurq8Jy5sxF5oPkxdQ@mail.gmail.com>
 <CAOpEvthWdQF98Egxv6z_2K-iLScjphV1kF67gH3ovdunxiQDig@mail.gmail.com>
 <CAOpEvtgpq8JU9MjZPW+55S15VBLRN2-anTMQ1XCfFnk7U0e8LA@mail.gmail.com>
 <CAOpEvtix+L+hWca=zUfN02mCCOqM9PNCwxnzbeqrVGA4BVhK=w@mail.gmail.com>
 <CAOpEvtg8LYHura=V3tXyJpRL+oMY3U2sPZZamNEnP7DVkapjUQ@mail.gmail.com>
 <CAOpEvthS__b1ipsR8EFO9Cag+c2o4boG3ei7o1eaUD1an+dbQg@mail.gmail.com>
 <CAOpEvtgnKmnc6vbPcaR9m6iiJe9mc1bHT3Bdrz1yDfrve-mrCQ@mail.gmail.com>
 <CAOpEvth+ofhDmfD8N59iLzPyOZnh9mFyVOvsgpQ0-LGc483s7g@mail.gmail.com>
 <CAOpEvtj+P_md_4f-zArv1x5Ltj7nfACeFVFeaZT5zRhw5rOcJQ@mail.gmail.com>
 <CAOpEvti6cbqQDUbPjmjQWx7dQ8ZRb3X30t-vCq9-K8Hw-L6+dQ@mail.gmail.com>
 <CAOpEvthY3TSdAZbyWof-xDm_B6_mP1wprKoWNfT1+-OuE2jPnQ@mail.gmail.com>
 <CAOpEvthsmx-QQm9W5AiN+hW3FCypPOy=zhL=um6wb=2NPcR70w@mail.gmail.com>
 <CAOpEvthjh+khZ-bZqMGbWjdPb81ZzoeVu5VF7-3b=Ocna9EouA@mail.gmail.com>
 <CAOpEvtjv_u7Uu+bPh9x8KpY8hQS+Dv_wWAmockAwPZkZLwb0HQ@mail.gmail.com>
 <CAOpEvthroXp6C8U6PKGwCBw9GpvsaX3Ko6Hbyma_OpUSn=m4iA@mail.gmail.com>
 <CAOpEvthk44UV789+f-ejxLwXYdndb8tF839J-n72Ukne6CtpcQ@mail.gmail.com>
 <CAOpEvthw87AJ9JrcUpeuqKuKDRgoerH7ji_f9JcWp5Q38OSBKg@mail.gmail.com>
 <CAOpEvtjsqv_SBz3MK9Z1TYGA10K49gygD4qs2PyPonoL+mHP7g@mail.gmail.com>
 <CAOpEvti+n+bs52z+GwReUUDG1DznLhqZi2Yy6xQ9HYpacgNPhw@mail.gmail.com>
 <CAOpEvthvBpqmd=fWv-DJNKh_BOXBf4gYCh0YB0D7hdVxObutBg@mail.gmail.com>
 <CAOpEvtigAddKEnrw3A52rFZZPL2Op34x_W1QwMmtbRvnAOs6FQ@mail.gmail.com>
 <CAOpEvti+yuF5bbZF7xP4NryceLNktewBgBBX5ejfG+nyk4ZtDw@mail.gmail.com>
 <CAOpEvtgVA=45-9mYkdCSgUOXwpBi85XYMc+aLaMCZE4-N1JY_w@mail.gmail.com>
 <CAOpEvth8gbPUUXqodGTvOmNizA=tLeyvSdg1Pw2YkVZiTHcmyQ@mail.gmail.com>
 <CAOpEvtiHDh1zTbgOMTBNr7rO36q1aWkTjbemPLCwPvqxigJnPQ@mail.gmail.com>
 <CAOpEvtjLN3QxftMZBU7eWn=0KxkpuyrmP4Rn3esXfq-5Zv8zVA@mail.gmail.com>
 <CAOpEvtj_2CvsZ7_Ak3e8cjz9=2uPL-vT7os9VWdfHApk=zPqTQ@mail.gmail.com>
 <CAOpEvtjsvVryRUgTjc9-YEQ2+rEVrJZNSXUm7NGXKj4ysxffkA@mail.gmail.com>
 <CAOpEvtgOKuMKMUHXshiFAz9ekBAar9ujV1Q4ZUJ8y6M_OU9yLg@mail.gmail.com>
 <CAOpEvtgFAfEYWSwg1-Jx94XBjaQwi8GNdTizZSay1FZNEVn2AQ@mail.gmail.com>
 <CAOpEvtiHBtRGfahURbke--K69X+kx72s2d8=iXkp2-xM1bbA2A@mail.gmail.com>
 <CAOpEvtgDQStNYZX1eYURBz+vR7my9sWp4dXP8UkpT=BPa0ZcqQ@mail.gmail.com>
 <CAOpEvtgt3siHZ_kF7DSWHddJq6Qm1GzJ5rgQRj9OTTY2x2totw@mail.gmail.com>
 <CAOpEvtjqeQhm_APx4_jkDYQBJfD2Hq5+KQE=JS9xY71jVwFv8w@mail.gmail.com> <CAOpEvtiCnodTkWRGEePkRKnENAbf_RxsrBSg9yMoHA7=dPXbCA@mail.gmail.com>
From:   lisa muna <amedodziyaovi@gmail.com>
Date:   Mon, 21 Feb 2022 17:38:18 +0100
Message-ID: <CAOpEvtgS8D3Lr4+twJ+TqYQAjvM-uXSdhg2_TPEtymhuuBAWkg@mail.gmail.com>
Subject: hi
Cc:     lisamuna2001@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

do you receive my massage
