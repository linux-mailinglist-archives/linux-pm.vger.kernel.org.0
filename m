Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9590B1F3FCF
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 17:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbgFIPtl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 11:49:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:32778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730944AbgFIPtk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Jun 2020 11:49:40 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54EAA206A4;
        Tue,  9 Jun 2020 15:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591717780;
        bh=cftoxf7eTWLgxLNNfMKJScg7CB9uhYQT3PXokWq0xF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EWjWRScXWtcnYf++U7silmPJbFplH3TnwReqlvYhihZ78m+YCyBoQJJZ5VgqvcFOH
         xMocALkjR79pqM6W8j7ddzFDiLQDpEVxcJ16cn2+lKzGIy4XSD9Rm83ZElDKjpwHCv
         6kr9n4O7m6sAOmUeMd6+RhHLg9sN91aerE50WA/g=
Received: by pali.im (Postfix)
        id 5893BFB6; Tue,  9 Jun 2020 17:49:38 +0200 (CEST)
Date:   Tue, 9 Jun 2020 17:49:38 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Mario.Limonciello@dell.com, Sebastian Reichel <sre@kernel.org>
Cc:     y.linux@paritcher.com, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org, mjg59@srcf.ucam.org
Subject: Re: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
Message-ID: <20200609154938.udo7mn7ka7z7pr6c@pali>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <0dc191a3d16f0e114f6a8976433e248018e10c43.1591584631.git.y.linux@paritcher.com>
 <83fe431cacbc4708962767668ac8f06f@AUSX13MPC105.AMER.DELL.COM>
 <79bd59ee-dd37-bdc5-f6b4-00f2c33fdcff@paritcher.com>
 <7f9f0410696141cfabb0237d33b7b529@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f9f0410696141cfabb0237d33b7b529@AUSX13MPC105.AMER.DELL.COM>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday 08 June 2020 20:36:58 Mario.Limonciello@dell.com wrote:
> Can you please comment here how you would like to see events like this should come
> through to userspace?
> 
> * Wrong power adapter (you have X and should have Y)
> * You have plugged a dock into the wrong port
> * Fn-lock mode

In my opinion, Fn-lock mode is related to input subsystem and should be
probably reported via input device. For a user, fn-lock is similar like
caps-lock, scroll-lock or num-lock. Also fn-lock is provided by other
laptops and therefore I would expect that kernel provide fn-lock state
for all laptops (thinkpad / latitude / ...) via same interface. And not
via dell-specific interface or general-vendor-message interface.

Wrong power adapter sounds like something related to power subsystem.
Adding Sebastian to the loop, maybe he can provide some useful ideas
about it.

And plugged dock into wrong port. This is probably dell-specific event
and some interface for "vendor" messages from kernel to userspace would
be needed to deliver such things.
