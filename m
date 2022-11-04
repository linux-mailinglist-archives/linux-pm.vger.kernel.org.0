Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F98061A1AC
	for <lists+linux-pm@lfdr.de>; Fri,  4 Nov 2022 20:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiKDT7U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Nov 2022 15:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiKDT7S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Nov 2022 15:59:18 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512BD45A23
        for <linux-pm@vger.kernel.org>; Fri,  4 Nov 2022 12:59:16 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id s4so3677854qtx.6
        for <linux-pm@vger.kernel.org>; Fri, 04 Nov 2022 12:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x16jINQR4q6R4H/0ehn+NSarZW0ZiXtTfCfHHiaRLp4=;
        b=bIdKEWgR5UZIy0TJaruQujMahMwynr4PVMnDcU4kBitHBNo7q073JbrYzG65FbHP7Y
         mbM9hFjlLlwQAouSAl9oSuR5cXI0K/JQyyZwmKs1co0JGtwjHN72PIS9n6MKeTRWxT7Z
         cCPuFkDzNQGR2KqOHNVW0/FBQA0CMharaPptg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x16jINQR4q6R4H/0ehn+NSarZW0ZiXtTfCfHHiaRLp4=;
        b=c9kD0sQB5e6/3cqhCHC/lywB86CDpZvI0XR4vp2N00fF8aPl0YJNdD6Y/x3WrbKO+2
         x1glBJAZgi2i1qcHsZF1vP0Kp59cpwjTijLzNT4CvpXnpBReEmQfoKT1fudFAEMT/sz0
         RF9k+S32tUIn/jS8xSkFyIIMZ2VpZaF1S2Czh0bzt41+ElpQXC4YNw6P9k4CmJ6kihh8
         v3FWM5u/uu+XMs/s4qUZzIUaYEZkvseMOeNBmi0SUCCYt863nxPbORZvDxn+sn41vGYX
         dqTnjeTp2QQkfEZ3YBvh3WKtMm8uUTaa56BNTrChP7coDw27J/coviVXUQc0K1d+rcbT
         17Pw==
X-Gm-Message-State: ACrzQf0g8uzEd6akv3cP30JRQDusaaVOI+879m0GQGlPB4sQVqtQygQJ
        XLVK97N8vZjGY3klLINFtBQv1JKC5Hz8zw==
X-Google-Smtp-Source: AMsMyM6BC3NiFnLTnWbPsN2qvLmVgqSpIGOe3nGA92dZCUthnVFZaBibps6DWv2H7+FicQAtZLxNsA==
X-Received: by 2002:ac8:5ac5:0:b0:39c:f8f5:c432 with SMTP id d5-20020ac85ac5000000b0039cf8f5c432mr30230655qtd.33.1667591955148;
        Fri, 04 Nov 2022 12:59:15 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id v20-20020a05622a145400b0035cd6a4ba3csm180026qtx.39.2022.11.04.12.59.14
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 12:59:14 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id j2so7022823ybb.6
        for <linux-pm@vger.kernel.org>; Fri, 04 Nov 2022 12:59:14 -0700 (PDT)
X-Received: by 2002:a0d:ef07:0:b0:373:5257:f897 with SMTP id
 y7-20020a0def07000000b003735257f897mr16823922ywe.401.1667591459021; Fri, 04
 Nov 2022 12:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221104054053.431922658@goodmis.org> <20221104192232.GA2520396@roeck-us.net>
 <20221104154209.21b26782@rorschach.local.home>
In-Reply-To: <20221104154209.21b26782@rorschach.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Nov 2022 12:50:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wge9uWV2i9PR6x7va4ZbPdX5+rg7Ep1UNH_nYdd9rD-uw@mail.gmail.com>
Message-ID: <CAHk-=wge9uWV2i9PR6x7va4ZbPdX5+rg7Ep1UNH_nYdd9rD-uw@mail.gmail.com>
Subject: Re: [RFC][PATCH v3 00/33] timers: Use timer_shutdown*() before
 freeing timers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-edac@vger.kernel.org,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-pm@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bluetooth@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, intel-gfx@lists.freedesktop.org,
        linux-input@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-leds@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org,
        bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, lvs-devel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 4, 2022 at 12:42 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Linus, should I also add any patches that has already been acked by the
> respective maintainer?

No, I'd prefer to keep only the ones that are 100% unambiguously not
changing any semantics.

              Linus
