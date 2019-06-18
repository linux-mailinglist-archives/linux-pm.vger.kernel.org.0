Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24EC4499B0
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2019 09:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfFRHBx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 03:01:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:45076 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbfFRHBx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Jun 2019 03:01:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7B4FB040;
        Tue, 18 Jun 2019 07:01:51 +0000 (UTC)
Message-ID: <1560841301.21660.9.camel@suse.com>
Subject: Re: [IMX] [DRM]: suspend/resume support
From:   Oliver Neukum <oneukum@suse.com>
To:     Pintu Agarwal <pintu.ping@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-pm@vger.kernel.org
Date:   Tue, 18 Jun 2019 09:01:41 +0200
In-Reply-To: <CAOuPNLiBA9VjEoG_D2y2O5mKiqsDNW1VZXOk1eWXpGY+h86acg@mail.gmail.com>
References: <CAOuPNLiBA9VjEoG_D2y2O5mKiqsDNW1VZXOk1eWXpGY+h86acg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Montag, den 17.06.2019, 19:19 +0530 schrieb Pintu Agarwal:

> Currently, I am trying to understand what needs to be taken care
> during suspend/resume.

You need to take care of

* wakeup sources
* not requiring services of devices higher up in the tree.

> With some reference, I figured out that hdmi power off/on needs to be
> done during suspend/resume.

That would make sense.

First of all you need to understand that the generic model is, well,
generic. Now this may look like a tautology, so let me explain.
A generic model cannot tell you how to save power on a specific
hardware. It exists to model dependencies among subsystems and
to help you.

The suspend() call is a notification which tells you that the rest
of the system will not require your services until resume() is
called().
That means that after resume() your driver must be functional again.

And it means that between suspend() and resume() you cannot touch
your device because what is above you in the tree need not be
functional.

> But after resume, system is hanging.
> It seems like vblank events are not getting triggered after the resume.
> May be irq remains disabled after resume, I need to figure out some
> way to enable the all the irqs again.

In your case it looks like parts of dw_hdmi_imx_bind() need to be
redone in resume().

	HTH
		Oliver

