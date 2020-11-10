Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EEC2AE05A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 20:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbgKJTzs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 14:55:48 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57211 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730618AbgKJTzs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 14:55:48 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AAJtbdJ011310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 14:55:37 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D5FA3420107; Tue, 10 Nov 2020 14:55:36 -0500 (EST)
Date:   Tue, 10 Nov 2020 14:55:36 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: How to enable auto-suspend by default
Message-ID: <20201110195536.GD2951190@mit.edu>
References: <fe8ab4cab3740afd261fa902f14ecae002a1122d.camel@hadess.net>
 <X6p6ubTOoMPUPPXi@kroah.com>
 <DM6PR19MB2636C94B56D5FBC0BD98A1B0FAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
 <X6rLUDuG0N98jz18@kroah.com>
 <DM6PR19MB2636460E97BD5E47957BB43AFAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
 <X6rVT6IXHYQpqjic@kroah.com>
 <DM6PR19MB263696FE5FA50F344B559488FAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR19MB263696FE5FA50F344B559488FAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

One note...  I'll double check, but on my XPS 13 9380, as I recall, I
have to manually disable autosuspend on all of the XHCI controllers
and internal hubs after running "powertop --auto-tune", or else any
external mouse attached to said USB device will be dead to the world
for 2-3 seconds if the autosuspend timeout has kicked in, which was
***super*** annoying.

						- Ted
