Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9964BC48
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 17:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfFSPEL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 11:04:11 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56789 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729670AbfFSPEL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 11:04:11 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BCB6B21FDF;
        Wed, 19 Jun 2019 11:04:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 19 Jun 2019 11:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=bByssVIB1EYoVBDtjxIgtcfTwUo
        glLh/NnUiLiEfkX0=; b=oAFnIERq3L6VDbDxgRBBWjQ3xY8j90qhh8vJHUTGZLB
        CDK1/u6VgadXtYMWVQPAYl3Quw/McWO8vaTywD5voBB4W8OWaAo0H7BxugSmHeJV
        RDvBpDn/SctaSD/bTizzqKdmjh37q1c7WJVUYZc1ylKPWkOQEcGUQxbbdgXgB5kF
        77rjm6vwX6TfTsX51Y3o+j8R446XRr7/jJpZ+MvXr5DE+6LDnqOE3vCd7uncKb8B
        UH7oFOdRCsolueXNhohrcxqJvDZCSufOHt9zPJwSH4UPu3XJhU0dojb1GvUExo4S
        +pSFxGcEIUdYxAJNKx5W01lQbMZdk7mb0jdHbzJKMMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=bByssV
        IB1EYoVBDtjxIgtcfTwUoglLh/NnUiLiEfkX0=; b=KhgbnI6HfVWgDdDXLGSBZu
        97dInziUuc/uOJvVd4riwn0K1f+viDCRp2UVytIwUbJhYRdv5z+QkO5VC2f4GXYq
        vhGnKUsASfQ3bJuKMi6jN2/Wnad+VViEIpC7HH58eezowtjLjYJa69ovdUa/Frvq
        RY2KriZeJiiiY/wB9qXkA7JTzUk3MiHWb2sMAY912YrjaXFDXvjcWA8niiYcfLDh
        bZSsLuJZIdxZfsY6ra8cL9tz0e3VYUsm1z87IJYnj5xB/r6v6d0SB4yeSis7wxUO
        rXf2bjH43FJbrEHHYpqSKWJX4iRrVZ7Cc3xqL4+3D+puoIUP9hBavWxpdLOwiwKA
        ==
X-ME-Sender: <xms:6U4KXXAPRUrSpmonf1WRmD5QzscjnUFx_TWVM9csytjNyxeYVTvcSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrtddvgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:6U4KXb7Nnl0Ge13Rmi0udpXmPHguTqGX_flvhiLe9SKd07EGtpn-Hw>
    <xmx:6U4KXapZrks3Q3sdLyQXcrwqCJI7hAF28FnXPW-1UfmDav6hWdRY7g>
    <xmx:6U4KXe9pZOoKj8fQ9ccN7c5oHzMFR6HfCHcoFe5Qpfi5V44Gbp-KIA>
    <xmx:6U4KXU5Z0zlnbhiGMIx1it26ccBG8_Dqki0dDwlmNt-4-9YFHV0G4g>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id E37AE380085;
        Wed, 19 Jun 2019 11:04:08 -0400 (EDT)
Date:   Wed, 19 Jun 2019 17:04:06 +0200
From:   Greg KH <greg@kroah.com>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: Re: [IMX] [DRM]: suspend/resume support
Message-ID: <20190619150406.GB19346@kroah.com>
References: <CAOuPNLiBA9VjEoG_D2y2O5mKiqsDNW1VZXOk1eWXpGY+h86acg@mail.gmail.com>
 <CAOMZO5BcLaS0gXUPi6oN6vjqagS5yf+rHh+EUjmi-Wi1OX7vqQ@mail.gmail.com>
 <CAOuPNLgEEfDca4aeT1+q8GfUfGzbJ4x6JwGf-ROB1pgpXUBHSw@mail.gmail.com>
 <CAOMZO5BY8JcLNMCRCC_d=emy8HR6kE=dB9f5qfZ=ci_c+Jak0w@mail.gmail.com>
 <CAOuPNLjYhkP_kL+q-ZpiDZMMpOHrU88BFBc2agtnCzXt8dihOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOuPNLjYhkP_kL+q-ZpiDZMMpOHrU88BFBc2agtnCzXt8dihOg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 19, 2019 at 07:03:39PM +0530, Pintu Agarwal wrote:
> You can think that the version I am using right now is almost 4.9 itself.
> Upgrading again to higher kernel version is again difficult, also
> customer does not want it.

They don't want a secure and supported kernel over the lifetime of their
device?  That sounds really odd.  Never create a new device using the
4.9.y kernel tree unless you have someone else doing the support for it
(i.e. a SoC vendor that you are paying support from).

good luck!

greg k-h
