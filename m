Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C29B4237B4
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 15:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733248AbfETM45 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 08:56:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:58430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728898AbfETM45 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 May 2019 08:56:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2C64AAE45;
        Mon, 20 May 2019 12:56:56 +0000 (UTC)
Message-ID: <1558356237.12672.3.camel@suse.com>
Subject: Re: [RFC v2 3/5] clk: bcm2835: use firmware interface to update pllb
From:   Oliver Neukum <oneukum@suse.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        stefan.wahren@i2se.com, Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        sboyd@kernel.org, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 20 May 2019 14:43:57 +0200
In-Reply-To: <20190520104708.11980-4-nsaenzjulienne@suse.de>
References: <20190520104708.11980-1-nsaenzjulienne@suse.de>
         <20190520104708.11980-4-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mo, 2019-05-20 at 12:47 +0200, Nicolas Saenz Julienne wrote:
> + * For more information on the firmware interface check:
> + * https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface
> + */
> +struct bcm2835_firmware_prop {
> +       u32 id;
> +       u32 val;
> +       u32 disable_turbo;
> +} __packed;

Hi,

technically we are not in arch and those fields have a defined
endianness.

	Regards
		Oliver

