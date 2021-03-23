Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24FB345ADB
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 10:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCWJbP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 05:31:15 -0400
Received: from foss.arm.com ([217.140.110.172]:42776 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229884AbhCWJbF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Mar 2021 05:31:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1413C106F;
        Tue, 23 Mar 2021 02:31:05 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 436803F718;
        Tue, 23 Mar 2021 02:31:03 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vireshk@kernel.org, Nicola Mazzucato <nicola.mazzucato@arm.com>,
        rjw@rjwysocki.net, cristian.marussi@arm.com,
        linux-kernel@vger.kernel.org, liviu.dudau@arm.com,
        Robin Murphy <robin.murphy@arm.com>, lorenzo.pieralisi@arm.com
Cc:     Sudeep Holla <sudeep.holla@arm.com>, ionela.voinescu@arm.com,
        chris.redpath@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH 1/2] arm64: dts: juno: Describe PCI dma-ranges
Date:   Tue, 23 Mar 2021 09:30:55 +0000
Message-Id: <161649138496.287180.16204999782047225082.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <720d0a9a42e33148fcac45cd39a727093a32bf32.1614965598.git.robin.murphy@arm.com>
References: <720d0a9a42e33148fcac45cd39a727093a32bf32.1614965598.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 5 Mar 2021 17:33:17 +0000, Robin Murphy wrote:
> The PLDA root complex on Juno relies on an address-based lookup table to
> generate AXI attributes for inbound PCI transactions, and as such will
> not pass any transaction not matching any programmed address range. The
> standard firmware configuration programs 3 entries covering the GICv2m
> MSI doorbell and the 2 DRAM regions, so add a "dma-ranges" property to
> describe those usable inbound windows.


(New commit info after rebase to v5.12-rc2 for obvious reasons)
Applied to sudeep.holla/linux (for-next/juno), thanks!

[1/2] arm64: dts: juno: Describe PCI dma-ranges
https://git.kernel.org/sudeep.holla/c/4ac4d146cb
[2/2] arm64: dts: juno: Enable more SMMUs
https://git.kernel.org/sudeep.holla/c/d9df28ba58

--
Regards,
Sudeep

