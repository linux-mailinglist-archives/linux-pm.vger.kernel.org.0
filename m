Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBBF39532
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 21:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbfFGTCq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 15:02:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728595AbfFGTCq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Jun 2019 15:02:46 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE94A20684;
        Fri,  7 Jun 2019 19:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559934165;
        bh=6ijabiDaN3rCu0hu1kgHMOs9Ptn6dV6k1ezaTuwgxzU=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=szhvC/O0F+NNx7xMJnyC4/QoN0Lo5c0iv/TSTZtYpQLc1iQKDRmBqA63VjWfm6um0
         Nhb4VXIlC2M+P7gMinLA6HMr0fxtH4Jho9mZLfniarc8DFVhwT65r9501gWnDxWP+m
         cDgv/SL+q4476Yw6r9XuQ7rME7Ap3L4g7o5eY9rs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b021ae9d-a38e-b300-d82e-d4f88fb0fe7a@i2se.com>
References: <20190606142255.29454-1-nsaenzjulienne@suse.de> <20190606142255.29454-5-nsaenzjulienne@suse.de> <20190606170949.4A46720652@mail.kernel.org> <eb72a26b55cf17c29df6a7fd3c5def08182e00af.camel@suse.de> <20190606173609.2C3952083D@mail.kernel.org> <153579ddd7e6bd1e5c860a7a01115e47c78a1442.camel@suse.de> <20190606182335.1D15F20872@mail.kernel.org> <20190607030901.qdnjj7udw7ky3sfx@vireshk-i7> <b021ae9d-a38e-b300-d82e-d4f88fb0fe7a@i2se.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 4/7] cpufreq: add driver for Raspbery Pi
Cc:     f.fainelli@gmail.com, ptesarik@suse.com, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, mbrugger@suse.de, eric@anholt.net,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        ssuloev@orpaltech.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
User-Agent: alot/0.8.1
Date:   Fri, 07 Jun 2019 12:02:45 -0700
Message-Id: <20190607190245.CE94A20684@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Stefan Wahren (2019-06-07 02:13:54)
> Hi Viresh,
>=20
> Am 07.06.19 um 05:09 schrieb Viresh Kumar:
> > On 06-06-19, 11:23, Stephen Boyd wrote:
> >> Yes, thanks. I see that largely follows the commit description so it
> >> looks OK to me.
> > Do you want to provide your Reviewed/Acked-by tag before I apply it ?
>=20
> Nicolas wanted to send a V3 of this series and as a platform maintainer
> i need some time for testing this version.
>=20

You can add my review tag.

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

