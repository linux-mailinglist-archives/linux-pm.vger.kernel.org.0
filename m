Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA6230B4E0
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 02:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhBBBwd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 20:52:33 -0500
Received: from mail-40134.protonmail.ch ([185.70.40.134]:57252 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhBBBwc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 20:52:32 -0500
Date:   Tue, 02 Feb 2021 01:51:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1612230709;
        bh=vLDhP23gdhlfN/nDrPZp3UYDiqejUrB6kY5RQEtOKS8=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=AVU/uD8LYdD6jL8K2EkOH3HHmSxHWXtaWkz0q62LY+aRVcB51G5vI75mZXpt55j+7
         8BH3zXYbiZiyjxE7A4esL3sDlTTXYQ84tHQvBiJwflOkTTO461Io63CDn7QHNqolYc
         nt6/G/F0oMZ1UNtpGf0UWJ5qPwIOdogxhyVYs8ow=
To:     Randy Dunlap <rdunlap@infradead.org>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: do not suspend/sleep
Message-ID: <_fXGHc0QxoA6O5ljZuheCXVM4m0EDO5yDitURpjxeesPWQ-etoD0Im3937FdotSufu1ZRtBaLFFsCzAY2qtNANeP829mo-YbOZhHksxn8HM=@protonmail.com>
In-Reply-To: <f4cfa048-f612-8e38-2899-988471d84faa@infradead.org>
References: <f4cfa048-f612-8e38-2899-988471d84faa@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi


2021. febru=C3=A1r 2., kedd 0:47 keltez=C3=A9ssel, Randy Dunlap =C3=ADrta:

> Hi all.
>
> I usually run my systems (laptops) so that they will suspend to RAM
> after 30 or 60 minutes of no use (no input), but when I am building
> e.g. 3 kernels, that will take more than 30 minutes and I don't want
> the system to suspend during that time.
>
> I was wondering what options are available to prevent entering suspend.
> I am willing to manually enter a command to make that happen if one
> is available.
> [...]

Have you looked at systemd-inhibit(1)?

Regards,
Barnab=C3=A1s P=C5=91cze
