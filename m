Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805CB25AB61
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 14:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgIBMrj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 08:47:39 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59938 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgIBMre (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2020 08:47:34 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200902124732euoutp02f777768b52c0f8611f13edd10c58aa02~w_Ec1L7Fl0643606436euoutp02B
        for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2020 12:47:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200902124732euoutp02f777768b52c0f8611f13edd10c58aa02~w_Ec1L7Fl0643606436euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599050852;
        bh=gjFiZoQjmNlgYKVBiHZ92aAN6y9PsbZAiFIHRgkZjJ8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NeCpYi58f93nN9rUREBP4UhYWfFGLLLohpqvvF+Ogd4dprRnA5dDRbS3szpSAOpw9
         CgfyQ+Nly9AE8YM7J+vlrbcidSguR2ult9L78X85GfVXWtxJ38qL3JQxYW4JB9DJqO
         CEx/sxElGV6ag3CAagiKo5s9p8Zj+UhWZu129oHw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200902124732eucas1p240a947627945fbf2c56579606daffcd5~w_EcinzUJ1052810528eucas1p2j;
        Wed,  2 Sep 2020 12:47:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C8.4C.05997.4649F4F5; Wed,  2
        Sep 2020 13:47:32 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200902124731eucas1p13716070977dbef39d09147bb71e050f6~w_EcQNPeI0524305243eucas1p1G;
        Wed,  2 Sep 2020 12:47:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200902124731eusmtrp12646df06a8a23fc3f2c4f181b1a5bb56~w_EcPT9Vg1487214872eusmtrp16;
        Wed,  2 Sep 2020 12:47:31 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-38-5f4f94646cfe
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2E.F5.06314.3649F4F5; Wed,  2
        Sep 2020 13:47:31 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200902124730eusmtip1f4f6f2bc3ae53e74490063a903236483~w_EbSw_Y81979819798eusmtip1E;
        Wed,  2 Sep 2020 12:47:30 +0000 (GMT)
Subject: Re: [PATCH v2 2/6] regmap: Use flexible sleep
To:     Dmitry Osipenko <digetx@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <d936a2fc-8890-eec1-015c-d919e10d1dc5@samsung.com>
Date:   Wed, 2 Sep 2020 14:47:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200830185356.5365-3-digetx@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2zk7O1tNjtPwJStxVtjNtEw+rCQj4SSh/epHkrb0oNG2bEcz
        gyi8t9RWKuosHbLwRiamlaaUZlqOzDLCrqZZNvGSaMUsu2zHyn/P877v877P8/HRhOK7eCl9
        WJvA6bQqtZKSkTc6bT0bYvLDo3x79WJcMDhM4bKOHjGumXqP8DlLgxiPDXUQOM1YTmJbZoMI
        D3y5j7CpZBHua75E4caxWoSnczoQPjtjpPBbawmJ23Mj8Jvu+xROb+2QYMvtBGxrLiV3uLCT
        /ekStsn4RsLWV5+l2NfPWyj2uvk0m5M6QbFd/TdFbGXNNwlrbqtA7HT9ir2y/bJtMZz68HFO
        tzHooCzOcGGOijcFnJi7HHgGffHRI5oGxh+s93R6JKMVTCUCc1qTRCAzCAznikUCmUbwrOwr
        0iOpQ1H9IYUUGhUIcuuuzksmEWSP2CT2KRcmAGoGPzoarswHEdTl33QQgrkmgpG7mY5dFOMH
        +nE9ZcdyJgheTT4R2THJrIQrE+cdM0uYSOjsHiKFGWd4WDxM2p1LmS1wqy7EXiYYD0htLCEE
        7AYvh8scvoGpoqHU+pkSfO+C4cq2eewCo10NEgEvA0teNikIUhEM9gh5gMlG0JdSNJ96K7zu
        maXslwlmDVxr3ig8XzAMffIWoBP0jzsLHpzg4o1CQijLIStDIexYDcau2n9X23qfEgakNC4I
        ZlyQxrggjfH/WRMiq5Ebl8hrYjl+k5ZL8uFVGj5RG+sTfVRTj/58ScvPrplbqPnHoXbE0Ei5
        WF4UFRalEKuO88madgQ0oXSV73xkiVTIY1TJJznd0Shdoprj25E7TSrd5JvLrQcUTKwqgTvC
        cfGc7m9XREuXnkGico8TpbvHM6xhXq3aX9LqrKmyuAN5BUGBahToOauwjtjem45FF0au7f4c
        csrf68VA2klp97oKc8Ti6H1D4erHLVcX7em8M+Pb5Oa+JEWTbZpIXn763YChxBCak8UTVQ96
        07+NToWOxaGJJNa1ybvPbOj3W13wdtX29T6eHl9jg5UkH6fyW0voeNVveSaWbo4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42I5/e/4Xd3kKf7xBsfX6FlMffiEzWL+kXOs
        Fqs/Pma06D69hdXizaMjzBYtsxaxWPxs38Jkcf/rUUaLBbO5LS7vmsNmsfXNOkaLz71HGC06
        v8xis7j3cjaLxaG+aIu7p46yWbTuPcJucXp3icXPXfNYHIQ93t9oZffYOesuu8emVZ1sHneu
        7WHz2Lyk3qO3+R2bx/Eb25k8Vqz+zu6x5OByRo/Pm+QCuKL0bIryS0tSFTLyi0tslaINLYz0
        DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0MiZM/MtWsMCs4u9cqwbGr3pdjJwcEgIm
        EqueNrF0MXJxCAksZZR4+3EXO0RCRuLktAZWCFtY4s+1LjYQW0jgLaPEic5SEFtYwExi9cNn
        7CDNIgJPmSRuPvsE5jALrGeS+H92NyNER7zEu3/3wLrZBAwlut5CTOIVsJO4/f4iE4jNIqAi
        sfRdP1i9qECcxJmeF1A1ghInZz4BOo+Dg1PAVGLHBleQMDPQ4nmbHzJD2PISzVtnQ9niEree
        zGeawCg0C0n3LCQts5C0zELSsoCRZRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgUth27Ofm
        HYyXNgYfYhTgYFTi4Z0R7xcvxJpYVlyZe4hRgoNZSYTX6ezpOCHelMTKqtSi/Pii0pzU4kOM
        pkC/TWSWEk3OByasvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFIN
        jC1R6lOWXupiKIv8veWFq+1ZntVNVnulXyQwn7I13SnRt+nLlDclHdNzHi57mPDlS5b3B/4H
        vQvrr7vUF3z0nsy7Z9bUKalm5sV/jWq3FitaTo8UYm8MdbbIe9kl2fBkfkS3sMCCxdzbLy9J
        fn+JQ2z/Eu+v76e7L5krVs/23m/7Hcnzs49NWaDEUpyRaKjFXFScCABbxlkYIAMAAA==
X-CMS-MailID: 20200902124731eucas1p13716070977dbef39d09147bb71e050f6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200902124731eucas1p13716070977dbef39d09147bb71e050f6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200902124731eucas1p13716070977dbef39d09147bb71e050f6
References: <20200830185356.5365-1-digetx@gmail.com>
        <20200830185356.5365-3-digetx@gmail.com>
        <CGME20200902124731eucas1p13716070977dbef39d09147bb71e050f6@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On 30.08.2020 20:53, Dmitry Osipenko wrote:
> The multi-reg write function uses udelay(), which is a busy-loop based
> delaying function that is not suitable for a long delays. Hence let's
> replace the udelay() with fsleep(), which is flexible sleep function that
> selects best delay function based on the delay-time.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

This patch landed in today's linux-next (20200902) as commit 
2b32d2f7ce0a. Sadly it breaks booting of ARM 64bit Amlogic S922X based 
Odroid N2 board. Here is the log:

BUG: scheduling while atomic: kworker/4:1/46/0x00000003
5 locks held by kworker/4:1/46:
  #0: ffff0000dfc06738 ((wq_completion)events){+.+.}-{0:0}, at: 
process_one_work+0x200/0x718
  #1: ffff80001320bdd0 (deferred_probe_work){+.+.}-{0:0}, at: 
process_one_work+0x200/0x718
  #2: ffff0000df4b6188 (&dev->mutex){....}-{3:3}, at: 
__device_attach+0x3c/0x150
  #3: ffff800012306e70 (enable_lock){+.+.}-{2:2}, at: 
clk_enable_lock+0x48/0x128
  #4: ffff0000de01c418 (syscon:110:(&syscon_config)->lock){+.+.}-{2:2}, 
at: regmap_lock_spinlock+0x14/0x28
Modules linked in:
CPU: 4 PID: 46 Comm: kworker/4:1 Not tainted 5.9.0-rc2+ #1570
Hardware name: Hardkernel ODROID-N2 (DT)
Workqueue: events deferred_probe_work_func
Call trace:
  dump_backtrace+0x0/0x1d0
  show_stack+0x14/0x20
  dump_stack+0xec/0x16c
  __schedule_bug+0x64/0x98
  __schedule+0x7e0/0x8a0
  schedule+0x78/0x118
  schedule_hrtimeout_range_clock+0x84/0x108
  schedule_hrtimeout_range+0x10/0x18
  usleep_range+0x88/0xb8
  _regmap_multi_reg_write+0x188/0x4e0
  regmap_multi_reg_write+0x38/0x58
  meson_clk_pll_init+0x80/0xd8
  meson_clk_pcie_pll_enable+0x48/0xd8
  clk_core_enable+0xc8/0x2b0
  clk_core_enable+0xa8/0x2b0
  clk_core_enable+0xa8/0x2b0
  clk_core_enable+0xa8/0x2b0
  clk_core_enable_lock+0x20/0x40
  clk_enable+0x14/0x28
  phy_g12a_usb3_pcie_probe+0x130/0x210
  platform_drv_probe+0x50/0xa8
  really_probe+0x110/0x400
  driver_probe_device+0x54/0xb8
  __device_attach_driver+0x90/0xc0
  bus_for_each_drv+0x70/0xc8
  __device_attach+0xec/0x150
  device_initial_probe+0x10/0x18
  bus_probe_device+0x94/0xa0
  deferred_probe_work_func+0x70/0xa8
  process_one_work+0x2a8/0x718
  worker_thread+0x48/0x460
  kthread+0x134/0x160
  ret_from_fork+0x10/0x1c
BUG: sleeping function called from invalid context at mm/slab.h:498
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 46, name: kworker/4:1
3 locks held by kworker/4:1/46:
  #0: ffff0000dfc06738 ((wq_completion)events){+.+.}-{0:0}, at: 
process_one_work+0x200/0x718
  #1: ffff80001320bdd0 (deferred_probe_work){+.+.}-{0:0}, at: 
process_one_work+0x200/0x718
  #2: ffff0000df4b6188 (&dev->mutex){....}-{3:3}, at: 
__device_attach+0x3c/0x150
CPU: 4 PID: 46 Comm: kworker/4:1 Tainted: G        W 5.9.0-rc2+ #1570
Hardware name: Hardkernel ODROID-N2 (DT)
Workqueue: events deferred_probe_work_func
Call trace:
  dump_backtrace+0x0/0x1d0
  show_stack+0x14/0x20
  dump_stack+0xec/0x16c
  ___might_sleep+0x1d4/0x1f8
  __might_sleep+0x4c/0x88
  slab_pre_alloc_hook.constprop.96+0xf4/0x138
  __kmalloc_node_track_caller+0x6c/0x288
  devres_alloc_node+0x54/0xc0
  devm_reset_control_array_get+0x34/0xc0
  phy_g12a_usb3_pcie_probe+0x148/0x210
  platform_drv_probe+0x50/0xa8
  really_probe+0x110/0x400
  driver_probe_device+0x54/0xb8
  __device_attach_driver+0x90/0xc0
  bus_for_each_drv+0x70/0xc8
  __device_attach+0xec/0x150
  device_initial_probe+0x10/0x18
  bus_probe_device+0x94/0xa0
  deferred_probe_work_func+0x70/0xa8
  process_one_work+0x2a8/0x718
  worker_thread+0x48/0x460
  kthread+0x134/0x160
  ret_from_fork+0x10/0x1c
------------[ cut here ]------------
kernel BUG at mm/vmalloc.c:2066!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
Modules linked in:
CPU: 4 PID: 46 Comm: kworker/4:1 Tainted: G        W 5.9.0-rc2+ #1570
Hardware name: Hardkernel ODROID-N2 (DT)
Workqueue: events deferred_probe_work_func
pstate: 00000005 (nzcv daif -PAN -UAO BTYPE=--)
pc : __get_vm_area_node+0x190/0x198
lr : get_vm_area_caller+0x34/0x40
sp : ffff80001320b9f0
x29: ffff80001320b9f0 x28: ffff8000124bf68d
x27: ffff0000e47ce005 x26: ffff0000e484a6a8
x25: 0000000000000009 x24: ffff80001220f000
x23: 0068000000000707 x22: ffff800010531544
x21: 0000000000000000 x20: 00000000ffe09000
x19: 0000000000001000 x18: ffffffffffffffff
x17: 0000000089f66c61 x16: 00000000b502d7d1
x15: ffff80001220fa48 x14: ffff0000de6df18a
x13: ffff0000de6df189 x12: 0000000000000030
x11: 0000000000000003 x10: ffff8000124f8c58
x9 : 0000000000000000 x8 : 00000000fffffffe
x7 : ffff800010531544 x6 : 0000000000000cc0
x5 : 00000000ffffffff x4 : fffffdffbfff0000
x3 : ffff800010000000 x2 : 0000000000000001
x1 : 0000000000000001 x0 : 0000000000001000
Call trace:
  __get_vm_area_node+0x190/0x198
  __ioremap_caller+0x68/0xe0
  __ioremap+0x38/0x40
  __devm_ioremap+0x7c/0xf8
  __devm_ioremap_resource+0xa8/0x160
  devm_ioremap_resource+0x10/0x18
  devm_platform_get_and_ioremap_resource+0x70/0x78
  devm_platform_ioremap_resource+0x10/0x18
  dwc3_meson_g12a_probe+0x60/0x518
  platform_drv_probe+0x50/0xa8
  really_probe+0x110/0x400
  driver_probe_device+0x54/0xb8
  __device_attach_driver+0x90/0xc0
  bus_for_each_drv+0x70/0xc8
  __device_attach+0xec/0x150
  device_initial_probe+0x10/0x18
  bus_probe_device+0x94/0xa0
  deferred_probe_work_func+0x70/0xa8
  process_one_work+0x2a8/0x718
  worker_thread+0x48/0x460
  kthread+0x134/0x160
  ret_from_fork+0x10/0x1c
Code: cb010000 11000400 17ffffe8 d503201f (d4210000)
---[ end trace b621320ae7bce6b7 ]---
Kernel panic - not syncing: Aiee, killing interrupt handler!
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x0240002,20082004
Memory Limit: none
---[ end Kernel panic - not syncing: Aiee, killing interrupt handler! ]---

Reverting this commit on top of current linux-next fixes board booting.

> ---
>   drivers/base/regmap/regmap.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index e93700af7e6e..a417cb1a11dc 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -2231,7 +2231,7 @@ static int _regmap_range_multi_paged_reg_write(struct regmap *map,
>   					return ret;
>   
>   				if (regs[i].delay_us)
> -					udelay(regs[i].delay_us);
> +					fsleep(regs[i].delay_us);
>   
>   				base += n;
>   				n = 0;
> @@ -2268,7 +2268,7 @@ static int _regmap_multi_reg_write(struct regmap *map,
>   				return ret;
>   
>   			if (regs[i].delay_us)
> -				udelay(regs[i].delay_us);
> +				fsleep(regs[i].delay_us);
>   		}
>   		return 0;
>   	}

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

