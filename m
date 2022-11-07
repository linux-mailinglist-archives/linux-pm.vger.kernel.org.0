Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4B061FF37
	for <lists+linux-pm@lfdr.de>; Mon,  7 Nov 2022 21:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiKGUMU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Nov 2022 15:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiKGUMS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Nov 2022 15:12:18 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF0F222BE
        for <linux-pm@vger.kernel.org>; Mon,  7 Nov 2022 12:12:17 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id d26so33125536eje.10
        for <linux-pm@vger.kernel.org>; Mon, 07 Nov 2022 12:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=enMdjmIsSbUUYGb+RiHPQULVTIcs0r1uA7QvgYehDfo=;
        b=cK5mzUepaprD41nCiRUmaLmzTIgcnNw5msQaClmACmYhAcO7XK6rJUBvOqZtgby6y8
         52QvjVVQH7ojFFZrM7qfAy0IdolyIX8knrA6IaYyvW21uhXHySccJ3/m2Wleu58EVtDt
         6MIVe9aRiDrWdsThdVgafQbhigdkLUk4g2knQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enMdjmIsSbUUYGb+RiHPQULVTIcs0r1uA7QvgYehDfo=;
        b=WDG3CgJTjj0MbSG9if358PLtQnh5lDueVFWsE68QsmfpaZteRcqTFhKCoGUmH3kcFH
         gwwuGtNJcA9jWuI1YoQoNCBwcuodpBbo/bMQ8In9QQpuZN2B6y+Durd/462qwvZjc6zY
         GASPRmmB+RwSNJbgobcdqCzLqMKIvy98E0czIkY15U2kOO1XZKORcrOAq+8wAywakma7
         1oCEZfZ8gxG+fN+HL3EjBbArH0aylRhUL87EgFqv4OSum0HuVqNnfzJvov/gkNfEyjJZ
         OkJjN/Bw/+NNliHkhOoleQXLsO8Bb7iBPxC3PlxTtSZfL3v37lltEvskszgOmEZawXCs
         Xxjw==
X-Gm-Message-State: ACrzQf1t7H9dH6FWpksgRku5ZLacINfqEOJBhRY9Dc6Y2D87Z5N8Vhip
        ta/akwXTj4JsZXeQiJlfyGhTxvhDk8o+CA==
X-Google-Smtp-Source: AMsMyM5a9sxjnIbCnEH9h3dbjdvBdKFSq0Ek7JAq8x2Egc9FQ0pyWxhGyp8jQymPDxmDbYhUxtfg/A==
X-Received: by 2002:a17:906:6a1b:b0:7ad:ba1e:879b with SMTP id qw27-20020a1709066a1b00b007adba1e879bmr46311135ejc.311.1667851936135;
        Mon, 07 Nov 2022 12:12:16 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id w23-20020aa7dcd7000000b00443d657d8a4sm4613117edu.61.2022.11.07.12.12.15
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 12:12:15 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id cl5so17871186wrb.9
        for <linux-pm@vger.kernel.org>; Mon, 07 Nov 2022 12:12:15 -0800 (PST)
X-Received: by 2002:a5d:6dc3:0:b0:22a:bcc3:21c6 with SMTP id
 d3-20020a5d6dc3000000b0022abcc321c6mr34070892wrz.450.1667851934711; Mon, 07
 Nov 2022 12:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20221103180120.752659-1-evgreen@chromium.org> <20221103105558.v4.4.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid>
 <202211041132.E8CB636@keescook>
In-Reply-To: <202211041132.E8CB636@keescook>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 7 Nov 2022 12:11:38 -0800
X-Gmail-Original-Message-ID: <CAE=gft4+KHVd_cNApo6EcTtxSDQDNB-nPXdus-0K8pQdWF+tiw@mail.gmail.com>
Message-ID: <CAE=gft4+KHVd_cNApo6EcTtxSDQDNB-nPXdus-0K8pQdWF+tiw@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] security: keys: trusted: Include TPM2 creation data
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, gwendal@chromium.org,
        apronin@chromium.org, Pavel Machek <pavel@ucw.cz>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 4, 2022 at 11:33 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Nov 03, 2022 at 11:01:12AM -0700, Evan Green wrote:
> > In addition to the private key and public key, the TPM2_Create
> > command may also return creation data, a creation hash, and a creation
> > ticket. These fields allow the TPM to attest to the contents of a
> > specified set of PCRs at the time the trusted key was created. Encrypted
> > hibernation will use this to ensure that PCRs settable only by the
> > kernel were set properly at the time of creation, indicating this is an
> > authentic hibernate key.
> >
> > Encode these additional parameters into the ASN.1 created to represent
> > the key blob. The new fields are made optional so that they don't bloat
> > key blobs which don't need them, and to ensure interoperability with
> > old blobs.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
>
> There's a lot of open-coded math for the bounds checking. I didn't
> immediately see any problems, but it'd be nice if there was a way to
> hook a fuzzer up to this, or at least write some KUnit tests to check
> boundary conditions explicitly.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thank you! Yes, agreed about all the bounds checking. I could probably
pull out the "check for src + 2 > end, then get_unaligned_be16()" into
a helper function. Let me see if that makes things look better or ends
up looking the same.
-Evan
