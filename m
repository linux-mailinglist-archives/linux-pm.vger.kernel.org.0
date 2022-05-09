Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD7F5202CB
	for <lists+linux-pm@lfdr.de>; Mon,  9 May 2022 18:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbiEIQr4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 May 2022 12:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239243AbiEIQrz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2022 12:47:55 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD471F68F9
        for <linux-pm@vger.kernel.org>; Mon,  9 May 2022 09:43:59 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id v66so15805893oib.3
        for <linux-pm@vger.kernel.org>; Mon, 09 May 2022 09:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XqWCEiFRZR6d7K91PH8ezSoYLh3BKRbhvIoPlxx9A7I=;
        b=HUq4PANpxSIB27eIQbGcBLcJ1kMRfgia2LIbn1U/sr3tsZ29aWkap3rwOThAhgUyct
         MW4AAxZzt0kalHcKw0VYco7ySwx5B0Q6L9DvBsfj/UbG57AwzHEN8a6JkyYUfNQ29VTC
         pohnxIWc1viOIWSeXqW8vA+HehX4XegFte3mA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XqWCEiFRZR6d7K91PH8ezSoYLh3BKRbhvIoPlxx9A7I=;
        b=2VS6yo6kmYupXfJeqI3yax+XRzRBtmqvmaBxzkYSSlt+/yZEXZnQ2bwRhK3Z0n93Kc
         C7IwjsNfjlnoCr6W5uU83BW+l4O+pecAo4+jTkqPPtHpZHjjNDSW1jawZMPvuW8oBFSx
         umFZsxts1n8S6z2ZvK7AIMnhJbevZ03P55BgLUKQ5jskZt+7QWb3nExG1bBnFebOiIkT
         d1P8DR8CHgJ45+T88HZdC0lxB1Bof4Xcg3MJ3dlhxbCmyItF4Pfg0efq288OAL0CCObp
         L/V0Iwzb2JqpuixhuE39MAoEJJyT/S74om40yqKY60fLbTSyr0w3M1mjFcxDpJcRSeGO
         0rYA==
X-Gm-Message-State: AOAM530G6fWKzdiMYiLZ5Q7BVFf+Tz3YLXtOCxncurXYHjeqMubl5miH
        izkxCFUNLHnaxfz8gL46tdS1X1wLtC1A5P4T
X-Google-Smtp-Source: ABdhPJzkk+ancvhyClQRXz0/L5XZBys8aw2vKZeCXCB8YYKbNlclO5T6xHaG0sMY46LtMzjMI6naug==
X-Received: by 2002:a05:6808:64c:b0:326:cbd3:3bc4 with SMTP id z12-20020a056808064c00b00326cbd33bc4mr2638892oih.167.1652114639268;
        Mon, 09 May 2022 09:43:59 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id a9-20020a9d6e89000000b0060603221280sm4839493otr.80.2022.05.09.09.43.56
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 09:43:57 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id s12-20020a0568301e0c00b00605f30530c2so10493014otr.9
        for <linux-pm@vger.kernel.org>; Mon, 09 May 2022 09:43:56 -0700 (PDT)
X-Received: by 2002:a9d:6953:0:b0:606:3534:168e with SMTP id
 p19-20020a9d6953000000b006063534168emr6192989oto.237.1652114636260; Mon, 09
 May 2022 09:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220504232102.469959-1-evgreen@chromium.org> <20220506160807.GA1060@bug>
In-Reply-To: <20220506160807.GA1060@bug>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 9 May 2022 09:43:19 -0700
X-Gmail-Original-Message-ID: <CAE=gft6m75T0UC2DBhfFhuSMW6TK7aatD_04sQ18WosgGVsATw@mail.gmail.com>
Message-ID: <CAE=gft6m75T0UC2DBhfFhuSMW6TK7aatD_04sQ18WosgGVsATw@mail.gmail.com>
Subject: Re: [PATCH 00/10] Encrypted Hibernation
To:     Pavel Machek <pavel@ucw.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Daniil Lunev <dlunev@google.com>, zohar@linux.ibm.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        rjw@rjwysocki.net, Gwendal Grignou <gwendal@chromium.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Hao Wu <hao.wu@rubrik.com>, James Morris <jmorris@namei.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Len Brown <len.brown@intel.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 6, 2022 at 9:08 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > We are exploring enabling hibernation in some new scenarios. However,
> > our security team has a few requirements, listed below:
> > 1. The hibernate image must be encrypted with protection derived from
> >    both the platform (eg TPM) and user authentication data (eg
> >    password).
> > 2. Hibernation must not be a vector by which a malicious userspace can
> >    escalate to the kernel.
>
> Can you (or your security team) explain why requirement 2. is needed?
>
> On normal systems, trusted userspace handles kernel upgrades (for example),
> so it can escalate to kernel priviledges.
>

Our systems are a little more sealed up than a normal distro, we use
Verified Boot [1]. To summarize, RO firmware with an embedded public
key verifies that the kernel+commandline was signed by Google. The
commandline includes the root hash of the rootfs as well (where the
modules live). So when an update is applied (A/B style, including the
whole rootfs), assuming the RO firmware stayed RO (which requires
physical measures to defeat), we can guarantee that the kernel,
commandline, and rootfs have not been tampered with.

Verified boot gives us confidence that on each boot, we're at least
starting from known code. This makes it more challenging for an
attacker to persist an exploit across reboot. With the kernel and
modules verified, we try to make it non-trivial for someone who does
manage to gain root execution once from escalating to kernel
execution. Hibernation would be one obvious escalation route, so we're
hoping to find a way to enable it without handing out that easy
primitive.

[1] https://www.chromium.org/chromium-os/chromiumos-design-docs/verified-boot/

> Best regards,
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
