Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF6E6150DC
	for <lists+linux-pm@lfdr.de>; Tue,  1 Nov 2022 18:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiKARhq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Nov 2022 13:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiKARhn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Nov 2022 13:37:43 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699161CB09
        for <linux-pm@vger.kernel.org>; Tue,  1 Nov 2022 10:37:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id u24so13567120edd.13
        for <linux-pm@vger.kernel.org>; Tue, 01 Nov 2022 10:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cdUAsiAgmBJ1jbIAcY/gGR+Z/7ih0XBIpAP4mnSXYwg=;
        b=U+3jcriNI6G3mRzAxSj20osZtTDZErBW8Nh3ObL1xuyZVmynG7VTQ6hdaJDZfvYuc4
         BsAvfNmsSOYVQr1aPoTaBNp/Wjsp/mcsuXhQVkBEvgszY1b+jniCkvoAvlnhfUO9/7Ew
         nYABzAW6uipYWW4pCOp3Jvxu/hanu2Vo9v1kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdUAsiAgmBJ1jbIAcY/gGR+Z/7ih0XBIpAP4mnSXYwg=;
        b=qU89293XOYQI06woxUuHm4RBMfiTdAHIFuTKRsJ0lWtYgxLmOEyC5LiSnGcK3J1P1q
         F7Vfz5u+BCxaetCs/hLivVVkhifJiBLlj+cal2gkOgx5sC1VJIPw5aCD+/Fjg9FJV6l4
         j9xmZBlaB7Q65W2CkWfu5VzuIFyFhkNrDF6PrnIsPraEDoDbXTmic/4aDYzft/a5/48f
         CKSvvgy4odn5i7e8zuVDJMqxASio/R5E/SpPNNkZS6flsByYW8p2OqBIjl4Kev0wvXKv
         jlA38rBldjwDH4vLoaDUQW1fX5RfDb7JOi78JRAAUqg1gDmKPhXhL9ax/N3bpTa0dpU2
         D9sg==
X-Gm-Message-State: ACrzQf0pmu8NiytZBLD/NpGXWfuc6uNMpMpboWLKTtNXE9hrSq4hSShP
        YWxprEPmCNZVZFG7mlgbe/YoyR47j9l/1rmE
X-Google-Smtp-Source: AMsMyM4oovNvYE2rTldzriYsx9FP6y3jXAIQ0D50132qFZPgFSlV3bpdc2AF+asi6Pz1mvesptLG9Q==
X-Received: by 2002:a05:6402:5159:b0:462:3e9f:a0a4 with SMTP id n25-20020a056402515900b004623e9fa0a4mr19702820edd.313.1667324258800;
        Tue, 01 Nov 2022 10:37:38 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id o7-20020a056402444700b00461aaa39efbsm4746229edb.0.2022.11.01.10.37.37
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 10:37:37 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 21so22816844edv.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Nov 2022 10:37:37 -0700 (PDT)
X-Received: by 2002:a05:6402:1947:b0:461:a47d:274 with SMTP id
 f7-20020a056402194700b00461a47d0274mr20093632edz.165.1667324257158; Tue, 01
 Nov 2022 10:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221031204320.22464-1-mario.limonciello@amd.com> <20221031204320.22464-2-mario.limonciello@amd.com>
In-Reply-To: <20221031204320.22464-2-mario.limonciello@amd.com>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Tue, 1 Nov 2022 13:37:26 -0400
X-Gmail-Original-Message-ID: <CAM7w-FXAGki+k9aP0wV1Qs8dKqpPXgY9ZJR_a83ETrUF6ZRZOw@mail.gmail.com>
Message-ID: <CAM7w-FXAGki+k9aP0wV1Qs8dKqpPXgY9ZJR_a83ETrUF6ZRZOw@mail.gmail.com>
Subject: Re: [RFC 1/3] PM: Add a sysfs file to represent whether hardware
 reached the deepest state
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Rafael J Wysocki <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        rrangel@chromium.org, platform-driver-x86@vger.kernel.org,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 31, 2022 at 4:43 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> +void pm_set_hw_deepest_state(u64 duration)
> +{
> +       suspend_stats.last_hw_deepest_state = duration;

I'm wondering if we could add a userspace notification here. Then
userspace wouldn't have to synchronize with the suspend/resume state
of the system when reading this entry.

What about sysfs_notify() ? Or via udev?

> +}
> +EXPORT_SYMBOL_GPL(pm_set_hw_deepest_state);
