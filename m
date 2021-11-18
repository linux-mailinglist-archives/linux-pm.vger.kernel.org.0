Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B8645644A
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 21:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhKRUgm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 15:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhKRUgm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Nov 2021 15:36:42 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A6DC061574
        for <linux-pm@vger.kernel.org>; Thu, 18 Nov 2021 12:33:41 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id i5so13983514wrb.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Nov 2021 12:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=EfUXEEINLQszA870ynwuSZ2Lf08STwo891yLHWgYUFU=;
        b=ZLNhm57pDYSN7nVaLatlLr2zlOUpHpXpfKGPhdjPkkzON7XqldHyxk+N5KmsfbJEqZ
         SGhXVXn5maQFYFQwNk+A0c5r3jh10fvLtq9k91rIhBQAvKUKd0TXb/MwlTZLlVSs5UF/
         rDqOqIVlmrkiKxj+910yklIJtBmd/mG//3xVGDv6CtnSWyg/gqbdrRSxnN+Izq9Z2v3b
         SXrf3aizAvESZGW2n1P8+RZ7TVFTdWU4Zg+6nU/ZEBlf/qfrt9fQ8R3FkYwe1HjhW3Fq
         wtVYlAtA4nS45/6nz1S7z3lczlqVqWqtzTu1/RozFlYWlgPFYpSU0kvVmxq3qJIe9wWD
         vKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=EfUXEEINLQszA870ynwuSZ2Lf08STwo891yLHWgYUFU=;
        b=irqdqMrTQYm3Y474yXJUXSiB/uIKlkZnapnvs8AvfKKQH5SKRArtwDqJfAW4ahmWgl
         X9CMQ/f8KMsq14p+oBDpSqH96JnxdM0V4Lm9/PgqYd3l4PUtb3TsQzO740axirvJbs9C
         pG7S/6rEGOmFlCECC3v3CqbUDssUwjUH9IrngPKCcZxfkLu3eWgwWngobj1nddlV4BRd
         5zH6OjepiBnZ0NZMg4UEy1wi+p53B0wtc1+NO+NotC+v3/MpM/RMBWGZU1oY3gBLCf5z
         aQNo34nYZOEqn0K0shR5u3P3TG3hk4pmUDa++qNrBCnC/A4mzcJO9oRkpvxSAtvUHp3c
         9Diw==
X-Gm-Message-State: AOAM531An0dGSC3K5PJWmgB0F1QnRRybWR+HHmztJN5VvVDsD181AQE4
        dSoseERxk9FuJdn1pk1DmsE=
X-Google-Smtp-Source: ABdhPJx1RGAefCdS9K6lVb3q1I66YXizjFffTzMiRHrhdzWFAr+JOb+sV3Bz6gJSA5IU0+MMTrI9OA==
X-Received: by 2002:adf:ce08:: with SMTP id p8mr390887wrn.154.1637267620349;
        Thu, 18 Nov 2021 12:33:40 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1a:f00:fc8d:4de8:c1d1:9213? (p200300ea8f1a0f00fc8d4de8c1d19213.dip0.t-ipconnect.de. [2003:ea:8f1a:f00:fc8d:4de8:c1d1:9213])
        by smtp.googlemail.com with ESMTPSA id o12sm858270wmq.12.2021.11.18.12.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 12:33:39 -0800 (PST)
Message-ID: <d9d76980-966a-e031-70d1-3254ba5be5eb@gmail.com>
Date:   Thu, 18 Nov 2021 21:33:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, Linux PM <linux-pm@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Warning due to "ALSA: hda: intel: More comprehensive PM runtime setup
 for controller driver"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I get the following warning caused by 4f66a9ef37d3 ("ALSA: hda: intel: More
comprehensive PM runtime setup for controller driver"):

snd_hda_intel 0000:00:1f.3: Unbalanced pm_runtime_enable!

Not sure how this patch was tested because the warning is obvious.
The patch doesn't consider what the PCI sub-system does with regard to
RPM. Have a look at pci_pm_init().

I'd understand to add the call to pm_runtime_dont_use_autosuspend(),
but for all other added calls I see no justification.

If being unsure about when to use which RPM call best involve
linux-pm@vger.kernel.org.
