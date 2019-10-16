Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBBA8D8C54
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 11:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391906AbfJPJP7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 05:15:59 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43949 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391885AbfJPJP7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 05:15:59 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191016091556euoutp028a385790a1591ff670e3f029a268f38b~OFdyCiCYb1014710147euoutp024
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 09:15:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191016091556euoutp028a385790a1591ff670e3f029a268f38b~OFdyCiCYb1014710147euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571217356;
        bh=9dORfT2C1mUG6n6ublUc6Js/kNhg/nSvlOn7r+wmFJ4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=sNdzysg8IV07QNG16Sqy/DKIqRHBTS5BGJOQaTDU2zaYxUBgBMC+HeYqZRshKMdmT
         qJ04kweMoohiCCraSv/ToLHiTYk6D4mm+VFIyn3ob4xoaKl0maAkb2Q2w9dnWGpdjz
         0joGX0IzVpR8VQYrNtOBDk+Mgd0HAV326YW6umUc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191016091556eucas1p11bbb7d273f8cce2bcb1ec23c429781ff~OFdxpaz0_0289802898eucas1p1V;
        Wed, 16 Oct 2019 09:15:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 04.EB.04469.CCFD6AD5; Wed, 16
        Oct 2019 10:15:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191016091556eucas1p2b94b3ca327b17248afc651cda1d57606~OFdxW4yHG2333023330eucas1p2c;
        Wed, 16 Oct 2019 09:15:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191016091556eusmtrp2f8dc80fafe484d2653d7fb16d861d72f~OFdxWGaIA0353103531eusmtrp2g;
        Wed, 16 Oct 2019 09:15:56 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-d3-5da6dfcc2389
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5F.FF.04117.CCFD6AD5; Wed, 16
        Oct 2019 10:15:56 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191016091555eusmtip2d51b4724fb25774ae834cd2813c1cc02~OFdwzmirq1657316573eusmtip2u;
        Wed, 16 Oct 2019 09:15:55 +0000 (GMT)
Subject: Re: [PATCH v4 1/6] opp: Handle target/min/max voltage in
 dev_pm_opp_adjust_voltage()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, vireshk@kernel.org,
        robh+dt@kernel.org, kgene@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <83933504-bef3-a1f5-1420-d3aa2864bab5@samsung.com>
Date:   Wed, 16 Oct 2019 11:15:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014062649.oegc2rwigmdv6kju@vireshk-i7>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7djPc7pn7i+LNeh7IWaxccZ6Vov5R86x
        WvQ/fs1scf78BnaLTY+vsVpc3jWHzeJz7xFGixnn9zFZrD1yl92ide8RdouNXz0sNj84xubA
        47FpVSebx51re9g8Ni+p9+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MGTcbWApamSsOdPaz
        NDBuZOpi5OSQEDCRWPPpGZDNxSEksIJR4kn3RGYI5wujxK/5/1khnM+MEl3vp7N1MXKAteyb
        xQ0RX84osan9FVT7W0aJtv5p7CBzhQXiJXZMOsAO0iAioCXx8mYqSA2zwB4miVUT1rOB1LAJ
        GEr0Hu1jBLF5Bewk/n7ZBhZnEVCV2PnvAhNIr6hAhMTpr4kQJYISJ2c+YQGxOQUsJY437wN7
        gVlAXKLpy0pWCFteYvvbOWAfSAhcY5d41riUGeJPF4n3a15C2cISr45vYYewZST+75zPBNHQ
        zCjRs/s2O4QzgVHi/vEFjBBV1hKHj19kBbmIWUBTYv0ufYiwo8Sb57uhocInceOtIMQRfBKT
        tk1nhgjzSnS0CUFUq0j8XjUdGuxSEt1P/rNMYFSaheS1WUjemYXknVkIexcwsqxiFE8tLc5N
        Ty02zEst1ytOzC0uzUvXS87P3cQITFin/x3/tIPx66WkQ4wCHIxKPLwJPctihVgTy4orcw8x
        SnAwK4nwzm9ZEivEm5JYWZValB9fVJqTWnyIUZqDRUmct5rhQbSQQHpiSWp2ampBahFMlomD
        U6qB0dn8gmmu8mJL71VOV4yKdy2PdE/I3sfTctZzRpmO4hwrnfiQHT++XXu+tn3rrNOJPxZ6
        cBx4tahH/yfLOnsdK950veIY1/+XDZy6xE/6X/1yQPyyZ/OeeoHA+p9Zpxj5j9y5f1Oq9zTz
        VMVXGzcsZgz68NN7fnqb2IYFny5e5yp6J+PaGzCzXYmlOCPRUIu5qDgRAG3vEoJUAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xe7pn7i+LNZj4kNli44z1rBbzj5xj
        teh//JrZ4vz5DewWmx5fY7W4vGsOm8Xn3iOMFjPO72OyWHvkLrtF694j7BYbv3pYbH5wjM2B
        x2PTqk42jzvX9rB5bF5S79G3ZRWjx+dNcgGsUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaW
        eobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZM242sBS0Mlcc6OxnaWDcyNTFyMEhIWAisW8Wdxcj
        F4eQwFJGidWHJzJDxKUk5rcodTFyApnCEn+udbFB1LxmlDi/7RkjSEJYIF5ix6QD7CD1IgJa
        Ei9vpoLUMAvsYZJoarnKCNFwiEliStM2dpAGNgFDid6jfWDNvAJ2En+/bGMDsVkEVCV2/rvA
        BGKLCkRIPN9+A6pGUOLkzCcsIDangKXE8eZ9YDXMAuoSf+ZdYoawxSWavqxkhbDlJba/ncM8
        gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzACN127OeWHYxd
        74IPMQpwMCrx8CrMXxYrxJpYVlyZe4hRgoNZSYR3fsuSWCHelMTKqtSi/Pii0pzU4kOMpkDP
        TWSWEk3OByaPvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjG3Z
        WZccbhxXOSnxOHPpW/aNSW76zY6V/1lvVCW+9bU9t3fZvwlTjqRt/hkUJNRzc2L4+taSFKmt
        AVx/rMOXreEsDOzdZ3XRd7/CDDfxLxFiCmo/41ZXPlZ3l0ie41YiX3/pwNznk+xOb2usjmjh
        YYjSeXp0vmK3bG6pjHjkT8W3DdqtEeoZSizFGYmGWsxFxYkA4b+6k+YCAAA=
X-CMS-MailID: 20191016091556eucas1p2b94b3ca327b17248afc651cda1d57606
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190910123636eucas1p250ec04901f227b947cc38936563f63b2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190910123636eucas1p250ec04901f227b947cc38936563f63b2
References: <20190910123618.27985-1-s.nawrocki@samsung.com>
        <CGME20190910123636eucas1p250ec04901f227b947cc38936563f63b2@eucas1p2.samsung.com>
        <20190910123618.27985-2-s.nawrocki@samsung.com> <20191002143310.GA15898@pi3>
        <ada1bb2f-a824-c34e-6561-04a35782a9b8@samsung.com>
        <20191014062649.oegc2rwigmdv6kju@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/14/19 08:26, Viresh Kumar wrote:
> I am waiting for Andrew to send me the next set of patches. You depend
> on only one of the patches ? In that case you can just pick that patch
> from his series, keep his authorship intact and make changes from 1/6
> and send along with your series.

Yes, only that single patch. I will incorporate my changes then and resend, 
thank you.
