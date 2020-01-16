Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01D3113F397
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 19:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390227AbgAPSmy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 13:42:54 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:44557 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388922AbgAPSmx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 13:42:53 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8D4E6513;
        Thu, 16 Jan 2020 13:42:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 16 Jan 2020 13:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=/7fhTR1f92cLpIrCbJ+2OWqkhpv
        1kl/VUQPVVPmZgEc=; b=FeT3Zq8GQ8qzz7uwZ61cvMkHaF09X3eo/FpFVoHqOD3
        fD2mUOt9ZN1aIwAIlALjLeieBa4NJV38bhYqf5lHt8/P6R0YWsGiFcsCGp8bjSUR
        S5i+v2OLYpL3wN994Aa6eLnpfnxUUyTbZUvbUxqjSpfIq2LN8SjA06t3Aeurr63g
        DFh3EId6sc4pd3ofGp0hCm2iQuuNFaFlTuOgifAF1YWmWiy9SJpZUZ4uCL+LTFOX
        eJi4VkmRq21YTtPj0kWerE278gG75nGVd7DUOonrl86y4ie2zd97oESJkTDNTbbx
        ZKDLTeMCZqgrvK4sgURIYvh0qyZLvgJjbQD3n62OZ1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/7fhTR
        1f92cLpIrCbJ+2OWqkhpv1kl/VUQPVVPmZgEc=; b=OGQecjOuzXXqPotapCj+I4
        hCuvcE20Lyo2NHyxVzMaaw5u6fApAawM44/CZ8My+gEWIpAs+A1W7yTbIl7stc4U
        ISwGutrvWf/fY6Wmt+BLTxJ1+sYJIxqNYL8oYFngXv80cCUmI4Kgyktp6E0jpCpR
        la10h+G6XmMbRRwLVVdI+K608MXDXZR1CuY72vVELP2tkdq2bnqgTQFu+9eyv4ml
        TWU4fhudiNebOAXbnIIuo3/9sIsJT7wmpFBg//qGKmdnYKIMlN5gZmtAGuVO2V8U
        L/HMsBy9jcqt7dhf/7FTqH8wbhGNS9Se5wRDTTxSRZlT7FmI2E9/H6+Ubg5IZw1w
        ==
X-ME-Sender: <xms:q64gXs06QPv33nJkcPtUk0Ur3ju3En2cj8wJxS3uN-QreHvl4-Pwrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrtdehgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgurhgv
    shcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucfkphepie
    ejrdduiedtrddvudejrddvhedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgv
    shesrghnrghrrgiivghlrdguvgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:q64gXtDAe7wB3ahvp589SNBrCT9khM1atZVGja4paJJTGI7rV0GEXQ>
    <xmx:q64gXukD8ZZnxNDb3j7CjbDibL3L_2233B4CJth2LKaOHbZep9jdOA>
    <xmx:q64gXmokCmoSG3Z4Djh47-T19UppDuXU2so7VC1b9R8rhdFOalZlKw>
    <xmx:rK4gXuY4u1yVTdjBmqiSUv6UekfymvvUZDtRPdiw9i8O_zgjZHdeEw>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id A8DE13060840;
        Thu, 16 Jan 2020 13:42:51 -0500 (EST)
Date:   Thu, 16 Jan 2020 10:42:50 -0800
From:   Andres Freund <andres@anarazel.de>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Tushar Dave <tushar.n.dave@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: intel_pch_thermal: Add PCI ids for Lewisburg
 PCH.
Message-ID: <20200116184250.qlvc3ilx2b42czqk@alap3.anarazel.de>
References: <20200115184415.1726953-1-andres@anarazel.de>
 <2a5e9df32e2df27297149a577512f6b1557de241.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a5e9df32e2df27297149a577512f6b1557de241.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 2020-01-16 05:53:13 -0800, Srinivas Pandruvada wrote:
> On Wed, 2020-01-15 at 10:44 -0800, Andres Freund wrote:
> > I noticed that I couldn't read the PCH temperature on my workstation
> > (C620 series chipset, w/ 2x Xeon Gold 5215 CPUs) directly, but had to
> > go
> > through IPMI. Looking at the data sheet, it looks to me like the
> > existing intel PCH thermal driver should work without changes for
> > Lewisburg.
> Does the temperature reading match with what you read via IPMI?

It does:

root@awork3:~# ipmitool sdr|grep ^PCH
PCH Temp         | 58 degrees C      | ok

andres@awork3:~$ cat /sys/class/thermal/thermal_zone0/type
pch_lewisburg
andres@awork3:~$ cat /sys/class/thermal/thermal_zone0/temp
58000

And if I generate some load, it rises for both:
root@awork3:~# ipmitool sdr|grep ^PCH
PCH Temp         | 60 degrees C      | ok
andres@awork3:~$ cat /sys/class/thermal/thermal_zone0/temp
60000

Regards,

Andres
