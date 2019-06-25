Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 805F755BD0
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 01:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfFYXAt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 19:00:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfFYXAt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Jun 2019 19:00:49 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A9512086D;
        Tue, 25 Jun 2019 23:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561503648;
        bh=XZFb1bPM2OTbilPsddH9Pql5EwgGw3s5eRnhL/AV5B0=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=YJooSIj28SxbPEkKyN2o5czbIwdY9TBypYR8CqhVO1KvbNY74WYo0kNy/F285NqIC
         OQVkiGFpuGCqaB7oGfRMcSC7efVBS8TG+xTKC7Qvl3PzpuDCG/S53UiMFvyZydKZGD
         C1A8ucallZI5P3yFYQGq3aLApzU3B8lLJR5Yilu0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190611175839.28351-4-nsaenzjulienne@suse.de>
References: <20190611175839.28351-1-nsaenzjulienne@suse.de> <20190611175839.28351-4-nsaenzjulienne@suse.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, stefan.wahren@i2se.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 3/7] firmware: raspberrypi: register clk device
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        eric@anholt.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 16:00:47 -0700
Message-Id: <20190625230048.6A9512086D@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Nicolas Saenz Julienne (2019-06-11 10:58:38)
> Since clk-raspberrypi is tied to the VC4 firmware instead of particular
> hardware it's registration should be performed by the firmware driver.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Acked-by: Eric Anholt <eric@anholt.net>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

