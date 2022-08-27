Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E06C5A3782
	for <lists+linux-pm@lfdr.de>; Sat, 27 Aug 2022 13:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiH0Lvq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 27 Aug 2022 07:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiH0Lvp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 27 Aug 2022 07:51:45 -0400
X-Greylist: delayed 530 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 27 Aug 2022 04:51:44 PDT
Received: from vorpal.se (vorpal.se [IPv6:2a01:7e00::f03c:91ff:fe73:398e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A59F6D9F6;
        Sat, 27 Aug 2022 04:51:44 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id CAACA14629;
        Sat, 27 Aug 2022 11:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1661601103; bh=+lWi1R2ztx0vQXT8GPdnO3tIG59SvPheEddxZ4vyZ5c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Qpy1e+JrNjA6ufAgLJCStsUkAd30xH8CKjLJNFS044E4eOMqigHbiDlCE2nk8W7yL
         G9c+FrosOQkH21DFI4May7klQ1EkGLlP06jNCenc6A8COP/NSx2k0W0smAm4FigIBD
         6Zpals57fR3EZGSfXWDXRlvuD1i/tDnXL5zR2N4EFbBZmU8BMnluY2eUQYFnTqVv1/
         5wtEpU/vRSPjEn2cUMjxVlI2G9BRj10vNI7twtBoU1K9IsXpVF7GjAe05S6xaR5lW8
         aExP7S1ketS7LD8Kaqmo7d2WaEExDmEDaLPUiz3eRuNe29jJYOIjHJZtOqGRGAFbnz
         J89x5u2NJp6xA==
Message-ID: <be56c117-a62d-e0b5-db50-71fda9c04f76@vorpal.se>
Date:   Sat, 27 Aug 2022 13:51:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/2] [RFC] platform/x86: Fixes for Toshiba Z830
Content-Language: en-US
To:     Azael Avalos <coproscefalo@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20220821200821.1837460-1-lkml@vorpal.se>
 <2ddade8b-7260-8497-12f2-c8b13cf35e6a@redhat.com>
 <12a39cf6-1247-d2a3-bf07-51297e9b6640@vorpal.se>
 <CAGdLNWFYizajrM3X7ww_=Yz6DiA34-eGoRfE0r=388+t3OAhWQ@mail.gmail.com>
From:   Arvid Norlander <lkml@vorpal.se>
In-Reply-To: <CAGdLNWFYizajrM3X7ww_=Yz6DiA34-eGoRfE0r=388+t3OAhWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        RCVD_IN_XBL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 2022-08-25 19:00, Azael Avalos wrote:
> Hi there
> 
> Sorry for pinging in a bit late, been under a lot of work lately.

It happens to all of us.

> You can poke the Toshiba BIOS interface directly via /dev/toshiba_acpi
> to test your findings, once it is ironed out, you can start making patches
> for inclusion in the kernel.

Interesting. I'm new to kernel development and I can't find where in
toshiba_acpi.c this is implemented. Nor do I see any documentation for this
interface. I would love some hints with regards to this.

For now I have been using the out-of-tree acpi_call module:

https://github.com/nix-community/acpi_call

Arch Linux (which I use) packages it as a DKMS module. Handy to test with,
but probably really easy to screw up your system using it if you don't know
what you are doing.

> I know there are a lot of areas where the driver is lacking features due to
> hardware restrictions on the machines I had at the time, so it's good to
> see a bit more movement here.
> 
> Cheers
> Azael
> 

Best regards,
Arvid Norlander

<snip>
