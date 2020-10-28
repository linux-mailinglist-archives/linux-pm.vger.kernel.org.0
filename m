Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F11E29E1DB
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 03:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgJ2CEN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 22:04:13 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:37841 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727200AbgJ1Vkx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 17:40:53 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 83137391;
        Wed, 28 Oct 2020 16:21:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 28 Oct 2020 16:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=tvzO3u8ximtfLtetGoZ5bDtCG8K
        Ex2uEX5PE3riL5Qk=; b=WkQAm15t2lksX7079w98tgwTTHYXSK8s5zvDlxnWeNA
        NZQFKvfLYHtnqKLNlxS5Dt4VxIP6SOeFchT/4lhUOFzGtX8x3YSzLZH/6lgichWb
        xunO8bmyDP+JspqMUFpOgNUVw+tfn7Uwh//37qQu2zobVANVlY455T4+xbSQ4nz8
        Pi+VUhVLXxhUyCzdCvfs4k+rcoXxyUEWLuSmD1J6yNKBQ21KOh0DA4NvwG/4eyej
        gE3WGfte1f3yCUs4OjpNspOiCS0Hy8PRKJLRPhfPBABekx8KyFxOkD7mPXpt/UX5
        gcFXBBe2uPvoQ/WU4asEBz3zZDCji6iGVU0RYeKNOtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=tvzO3u
        8ximtfLtetGoZ5bDtCG8KEx2uEX5PE3riL5Qk=; b=TjLzXiLb7C1bP3dFxc/hKW
        h2PFDvJmKJYBkKhtoz+/KDkpleQKtEzRQty8zi6yfU+uqSmBthb4smnyVuMyW8oK
        00AH3F7peSOm1vAWymoWUHnSpYS8XgrCU/h5PO+OxyEyEwUNkVHbo6eTPS53dLgq
        dr9gw/zQCrf4TN7hDPYLa6pl8VKsvGjnYKBURx4p+Hz0ftygSRLpN5+iqsrKlMZK
        9FttsRgoP52hTfmbUjwFhhSuBfobsLyF6zSDRgCYh7A6k8hCsOV/O5WRGtG5hDgd
        C/MEcdaePSmpwAXibGgyiaXERxza8SEO8+QR5oMvDBOVTUiMIOWmqOgNUivKnOew
        ==
X-ME-Sender: <xms:r9KZX73JeYVFZ87lpHjwYA4xFkrkXjgP7RV73X4xpy2zKvPh_LNOyw>
    <xme:r9KZX6HPTGir2nxcIHbIeUfjZYCsMaDFOIQoKrmyqSgN-4P-f1i3rYfJ4mGLt1KqH
    1xCXxxzsZrqNzj3aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrledvgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughrvghs
    ucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrfgrth
    htvghrnhepgfffveetveffudeluefhleegudektdevtedthedtgeevudffveegieejfeff
    feeunecuffhomhgrihhnpegrtghkrdhpihhnghenucfkphepieejrdduiedtrddvudejrd
    dvhedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    rghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:r9KZX75lC2kG_Xjifgy_0QyjmGCIX-pD5_N9bJp3BPZHDMY3s02eiQ>
    <xmx:r9KZXw1yTsu0i1lcW6upjw6yENe-jBC3Zeo1CUsvZ9c2dxyeZ-YDxg>
    <xmx:r9KZX-EBHrFqjn05BnXCcD9plHeMeDFYCSnKbBgqRRtS7koUxGkQGA>
    <xmx:sNKZXzQKWTmxqDtIOVKsD-0UBDMuS2UMhLlcmjIDge97OwnCqcoKyA>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id DD76B3064686;
        Wed, 28 Oct 2020 16:21:02 -0400 (EDT)
Date:   Wed, 28 Oct 2020 13:21:01 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Tushar Dave <tushar.n.dave@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: intel_pch_thermal: Add PCI ids for Lewisburg
 PCH.
Message-ID: <20201028202101.2m2jp3tfa6mh3brz@alap3.anarazel.de>
References: <20200115184415.1726953-1-andres@anarazel.de>
 <2a5e9df32e2df27297149a577512f6b1557de241.camel@linux.intel.com>
 <20200116184250.qlvc3ilx2b42czqk@alap3.anarazel.de>
 <2de70e961f24592d2d157b8586526df2eaf0ae6e.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2de70e961f24592d2d157b8586526df2eaf0ae6e.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 2020-01-16 11:41:34 -0800, Srinivas Pandruvada wrote:
> On Thu, 2020-01-16 at 10:42 -0800, Andres Freund wrote:
> > Hi,
> > 
> > On 2020-01-16 05:53:13 -0800, Srinivas Pandruvada wrote:
> > > On Wed, 2020-01-15 at 10:44 -0800, Andres Freund wrote:
> > > > I noticed that I couldn't read the PCH temperature on my
> > > > workstation
> > > > (C620 series chipset, w/ 2x Xeon Gold 5215 CPUs) directly, but
> > > > had to
> > > > go
> > > > through IPMI. Looking at the data sheet, it looks to me like the
> > > > existing intel PCH thermal driver should work without changes for
> > > > Lewisburg.
> > > Does the temperature reading match with what you read via IPMI?
> > 
> > It does:
> > 
> > root@awork3:~# ipmitool sdr|grep ^PCH
> > PCH Temp         | 58 degrees C      | ok
> > 
> > andres@awork3:~$ cat /sys/class/thermal/thermal_zone0/type
> > pch_lewisburg
> > andres@awork3:~$ cat /sys/class/thermal/thermal_zone0/temp
> > 58000
> > 
> > And if I generate some load, it rises for both:
> > root@awork3:~# ipmitool sdr|grep ^PCH
> > PCH Temp         | 60 degrees C      | ok
> > andres@awork3:~$ cat /sys/class/thermal/thermal_zone0/temp
> > 60000
> > 
> Thanks for the test.
> 
> Rui can add his ACK.

Ping? Looks like this got lost somewhere?

Greetings,

Andres Freund
