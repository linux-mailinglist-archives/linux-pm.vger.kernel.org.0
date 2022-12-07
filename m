Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6687646595
	for <lists+linux-pm@lfdr.de>; Thu,  8 Dec 2022 01:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiLHADF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Dec 2022 19:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiLHACs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Dec 2022 19:02:48 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F10862E0
        for <linux-pm@vger.kernel.org>; Wed,  7 Dec 2022 16:02:46 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id m6-20020a9d7e86000000b0066ec505ae93so6752616otp.9
        for <linux-pm@vger.kernel.org>; Wed, 07 Dec 2022 16:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pys7YHXlD6v5DSBXAVWpucw13OzZ4BiOPZmXbiQzjAA=;
        b=Vj44kd0ygeqnZ6PZpXz4+6ktl2PMHONahY1zAdD5HAfm8zcg7KVDmU8h6/3V5MJKwZ
         hrxmda5sOojj4G8VI9CwdoU+UaZUrPS6fkrZglSVUePffkg5HlUDS21p8TAcbplh5xZo
         TnX9g8LyhRBUi6HDUo56xgYU4jVuOUlpGnYog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pys7YHXlD6v5DSBXAVWpucw13OzZ4BiOPZmXbiQzjAA=;
        b=Hbisnf35PAmMtYpowbugGW6NnMJJFKM5/MZGq+lcUD/ZgmWRGqnhCQhJOG8Xv/oQpJ
         8OvdgcFcbrDHS+7OT7IBaRi9LD+2Dky2+pNBrLWGf4gk9TROlYphSXYcw3tE4Zs0ah4x
         j4ul9JEpWgRG6kKzHejjT0y4Pxgu4tSzlsc+iFoP7cewmQJ+JAgS+Ptdp265sGTNZLAc
         e7I/OaqIuXJrWWGxbrs+YfepXoMKxoL8XcJycLThcYeAYMM+OOPPC5/aUlpJ9j8ioy8t
         eJQE/yh/pswgRE+MBEYJOjqUbr0b2AwmYt4I0J8mCbk0MzgvfI4KGFViOLMWVktJAlD1
         XBNQ==
X-Gm-Message-State: ANoB5pmr5OegIncUuVaOuPAiy3YUvDpMSl0F7BOX79pzFJr5ZPTuPF27
        osq18rncPS4/iri0jjAwsgxH95GIrxqhkzgb
X-Google-Smtp-Source: AA0mqf4Y12MFkHAp+sFuCPqOSsCH0c5CqLDrIogZ4Ja953l/t9iOWMrjF/edEIAhDhBJZfUBgthjwA==
X-Received: by 2002:a9d:6514:0:b0:661:dfeb:a975 with SMTP id i20-20020a9d6514000000b00661dfeba975mr473404otl.32.1670457764970;
        Wed, 07 Dec 2022 16:02:44 -0800 (PST)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id i21-20020a9d68d5000000b00662228a27d3sm10864438oto.57.2022.12.07.16.02.44
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 16:02:44 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id q6-20020a4aa886000000b004a083f945a6so4695oom.6
        for <linux-pm@vger.kernel.org>; Wed, 07 Dec 2022 16:02:44 -0800 (PST)
X-Received: by 2002:a25:d642:0:b0:6f7:15b:70f5 with SMTP id
 n63-20020a25d642000000b006f7015b70f5mr45506521ybg.172.1670457334085; Wed, 07
 Dec 2022 15:55:34 -0800 (PST)
MIME-Version: 1.0
References: <20221111231636.3748636-1-evgreen@chromium.org>
In-Reply-To: <20221111231636.3748636-1-evgreen@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 7 Dec 2022 15:54:57 -0800
X-Gmail-Original-Message-ID: <CAE=gft46BNGmfy7u6gXQvmSzq=W2kpT6GYG_NH5Tg5NSH=MEiQ@mail.gmail.com>
Message-ID: <CAE=gft46BNGmfy7u6gXQvmSzq=W2kpT6GYG_NH5Tg5NSH=MEiQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] Encrypted Hibernation
To:     linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, jejb@linux.ibm.com,
        Kees Cook <keescook@chromium.org>, dlunev@google.com,
        zohar@linux.ibm.com, Matthew Garrett <mgarrett@aurora.tech>,
        jarkko@kernel.org, linux-pm@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Len Brown <len.brown@intel.com>,
        Matthew Garrett <mjg59@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org, greg@enjellic.com,
        casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello, it's me again!

On Fri, Nov 11, 2022 at 3:19 PM Evan Green <evgreen@chromium.org> wrote:
>
> We are exploring enabling hibernation in some new scenarios. However,
> our security team has a few requirements, listed below:
> 1. The hibernate image must be encrypted with protection derived from
>    both the platform (eg TPM) and user authentication data (eg
>    password).
> 2. Hibernation must not be a vector by which a malicious userspace can
>    escalate to the kernel.
>
> Requirement #1 can be achieved solely with uswsusp, however requirement
> 2 necessitates mechanisms in the kernel to guarantee integrity of the
> hibernate image. The kernel needs a way to authenticate that it generated
> the hibernate image being loaded, and that the image has not been tampered
> with. Adding support for in-kernel AEAD encryption with a TPM-sealed key
> allows us to achieve both requirements with a single computation pass.
>
> Matthew Garrett published a series [1] that aligns closely with this
> goal. His series utilized the fact that PCR23 is a resettable PCR that
> can be blocked from access by usermode. The TPM can create a sealed key
> tied to PCR23 in two ways. First, the TPM can attest to the value of
> PCR23 when the key was created, which the kernel can use on resume to
> verify that the kernel must have created the key (since it is the only
> one capable of modifying PCR23). It can also create a policy that enforces
> PCR23 be set to a specific value as a condition of unsealing the key,
> preventing usermode from unsealing the key by talking directly to the
> TPM.
>
> This series adopts that primitive as a foundation, tweaking and building
> on it a bit. Where Matthew's series used the TPM-backed key to encrypt a
> hash of the image, this series uses the key directly as a gcm(aes)
> encryption key, which the kernel uses to encrypt and decrypt the
> hibernate image in chunks of 16 pages. This provides both encryption and
> integrity, which turns out to be a noticeable performance improvement over
> separate passes for encryption and hashing.
>
> The series also introduces the concept of mixing user key material into
> the encryption key. This allows usermode to introduce key material
> based on unspecified external authentication data (in our case derived
> from something like the user password or PIN), without requiring
> usermode to do a separate encryption pass.
>
> Matthew also documented issues his series had [2] related to generating
> fake images by booting alternate kernels without the PCR23 limiting.
> With access to PCR23 on the same machine, usermode can create fake
> hibernate images that are indistinguishable to the new kernel from
> genuine ones. His post outlines a solution that involves adding more
> PCRs into the creation data and policy, with some gyrations to make this
> work well on a standard PC.
>
> Our approach would be similar: on our machines PCR 0 indicates whether
> the system is booted in secure/verified mode or developer mode. By
> adding PCR0 to the policy, we can reject hibernate images made in
> developer mode while in verified mode (or vice versa).
>
> Additionally, mixing in the user authentication data limits both
> data exfiltration attacks (eg a stolen laptop) and forged hibernation
> image attacks to attackers that already know the authentication data (eg
> user's password). This, combined with our relatively sealed userspace
> (dm-verity on the rootfs), and some judicious clearing of the hibernate
> image (such as across an OS update) further reduce the risk of an online
> attack. The remaining attack space of a forgery from someone with
> physical access to the device and knowledge of the authentication data
> is out of scope for us, given that flipping to developer mode or
> reflashing RO firmware trivially achieves the same thing.
>
> A couple of patches still need to be written on top of this series. The
> generalized functionality to OR in additional PCRs via Kconfig (like PCR
> 0 or 5) still needs to be added. We'll also need a patch that disallows
> unencrypted forms of resume from hibernation, to fully close the door
> to malicious userspace. However, I wanted to get this series out first
> and get reactions from upstream before continuing to add to it.
>
> [1] https://patchwork.kernel.org/project/linux-pm/cover/20210220013255.1083202-1-matthewgarrett@google.com/
> [2] https://mjg59.dreamwidth.org/58077.html
>

Doug found a practical problem with this design. The security of this
mechanism depends on the kernel being able to prevent usermode from
manipulating PCR23. While this series has managed to add that gating
to the standard /dev/tpm interface, at least on ChromeOS, there are
still many "dangerous toys" lying around that might allow a malicious
root to communicate directly with the TPM. This raw access could allow
usermode to extend PCR23 manually and forge malicious hibernate images
that appear genuine. Examples of raw access include 1) i2cget -F, 2)
unbinding the driver and binding i2c-dev instead, 3) using /dev/mem to
manipulate the i2c controller registers directly, and 4) my favorite,
remuxing the i2c pins to GPIO and bitbanging.

We did some brainstorming and came up with a pivot that has the
benefits of 1) reusing a decent chunk of this series, 2) not taking
PCR23 away from usermode (which based on other comments seemed like it
might not fly anyway), and 3) pushing the TPM interaction back down
into usermode. The new element we take advantage of is that our early
userspace is still considered trusted, as we sign the rootfs and
protect it with dm-verity.

The idea is to have early userspace ask the TPM to create a sealed key
bound to a (non-resettable) PCR. We then save the blob to disk, extend
the PCR (to prevent future unsealings in this boot), and push the key
material up to the kernel for use as a "hibernate seed". The kernel
will hold this seed in memory, and at hibernate time will use it to
encrypt a randomly generated "bulk key". The bulk key is then used to
encrypt the main hibernate image. So on disk at hibernate, we have 1)
the encrypted hibernate image, protected by the bulk key, 2) the bulk
key, protected by the seed, and finally 3) the seed, a TPM-protected
key blob that can only be unsealed when a PCR is set to its boot
value. In our own userspace implementation we'd seal this against a
firmware PCR as well, to differentiate between Verified mode and
Developer mode.

At resume time, early userspace would find the blob, successfully
unseal it (because the PCRs had reset back to the value that matches
the policy), and push the recovered seed to the kernel. It can then
push the encrypted bulk key and encrypted hibernate image. On our
systems, this works fine as the PCRs seem to always reset across
hibernate. Is that true generally as well?

So my plan for the next spin of this series looks something like:
 * Drop the tpm: and security: subsystem patches
 * Keep the gist of the PM: patches as is, but instead of the TPM stuff...
 * Introduce two new sysfs files, one to allow usermode to save the
seed into kernel memory, and another to lock out future changes to the
hibernate seed (until the next reboot).
 * Use the hibernate seed to encrypt a randomly generated bulk key,
which is then used to encrypt the main hibernate image.
 * Keep the "PM: mix user key in" patch, as we still need the image to
be encrypted with a key based on user authentication data, which this
new mechanism alone doesn't provide.

Anyone have any big objections to that plan, or see new gaping holes
in the idea? In the end I think it's actually a little nicer, as it
decouples all of the TPM-specific machinery from the concept of secure
hibernate, as well as not trying to police PCR access. Casey and Greg,
I'm going to guess you don't want to be CCed on the next spin, given
that I'm dropping the notion of taking PCR23 away from userspace.
Please holler if you would like to be CCed.

-Evan
