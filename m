Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABB8514792E
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2020 09:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgAXIGm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jan 2020 03:06:42 -0500
Received: from sonic308-1.consmr.mail.bf2.yahoo.com ([74.6.130.40]:35321 "EHLO
        sonic308-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbgAXIGm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jan 2020 03:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579853201; bh=+JEosOT2sVu+hkruxS8M8QchlzaUMN4I7aAE0kLIJgE=; h=Date:From:Reply-To:Subject:References:From:Subject; b=WUy5dmiCjc2gEn0qnMK8JQ5F27qlgQ8pzhBfDXSyV5Um7+LDycSfOzLsnStjEyQZDoOPQ8mDMs4/JCWYLgnOPC/FD0WStFllTMsZUr9bRGy8EatGq3p4WfXXQD3L5LIc6bZvkPxQIZi6f+ewm1TZNBTEsSJ65UlPd7cIZFZPIr6rD+5GYUsJ4GtmSxICVojtdUms+swdtjjXLYyoFvczW7pVt1zY7v2ZO5NUPozwRJAmio9YGay4psxFpvtNsXepIgE4PKjLH5SAd315dGt5Hq/YZMLblWzfele8Tfja1M3MEtlVU7NDNkZT3dft3lBir/ainKoTZMW2OmF+5srQbQ==
X-YMail-OSG: bc.adU0VM1nNTX6ITdqWVQeubCrDw7HDTzzJhBYJOGHilj1d6WrrUtLUOHTpKZ4
 7kOU2xavSw39eZKAyPSLIW_K3yzQkvBYS2YI6CkLUUzzTqH7H1A1uM4g1UiwiAW68R2M5liDcBom
 2Az0ILJmzggrmVxKWWS8gHedr7KlUsXbHN01zxJqQaF3w1P1qNR6.wDPoNhqVIw8GXfTeHLYeJLX
 OJg86dPGhRFXsL7nebgtSslyR3i3RbZENQ7wEvDphl2pkdT2t8rBUX_g6J2v4Ydnk7xZ1jhuiRFt
 xf1WxH5go2L3Cpt6eSTuQMxd69iAR4fwFgTinF95Jj6Re2nRP1ilE0QNcIhv.CCO49ndthzLjJVg
 iNSuMkKI9oEFdJWbnr6bkK.QTKlAIfra9AurCK6Ys1iBGmxVxciYlos9cTWxOA88SACuE33AXLeS
 o4lsQ_3ZQvfS_KpTsxMKcrO_d5i.Frc1D.iwZnqJ8cMDS2BeZoyeRFA6R7MiqKp_1qSIi.Xgf3XA
 HQ2ZOttSKkuNlaTt.WIgdXA0b2EsJTpRU8VfjmLXoPBgjmxNhWwnPnKoz47d2X.NBkF7mbbIZjUT
 bMAGSnCIRvmkU8RzmxdRG2c.oj0M3V4aPNrct6HjnnjD7DquiATQt_HyPueweP.txgvwR0eqrZwd
 TFsljkgDjJdAYUvAYftN2keEUfoFc8NVMwMpiYxEyEWHmOkytuMD8E7LyXQVcgdFL22810BopLaT
 FO.G7KusfC7e6ozSaJkDkTe.p7ZTTMzodZ70pYqhf9E1yGs7fYFzdEBGqlS395FTAu3ZmLvA1Fqk
 LA08Xe4CKq3ExN.QWNHZJiMsoWivvqJkQWZlwTiVqIk.oumpHehbePwNIRnOwb0PPTJT2z7ygmZo
 4zbGRH_0WTnMDPUN1UlDBQ8fUEAe9CHaq1aHX.T8YRN1Y6wYRC9yA8HgZa8AeE8abaxhUzF3U.PA
 cxBOPe31Xq8SYXSOXGzXtlQSk3qUrs1ZXanKoqaUQY1_9HN324AVapfK71Rfd6pXHFV_Nay3Vq1N
 WaSVx.C.jcRWO_VoMbXdQVVT3vaNgI7ck6wnnMTM6hu7yipMd50ebRpsE7laPpAOhR7bXUqRNpZg
 n9DKb0hydIv5fl2fIi4i.wue8Q8SqCX9c2v9gKaFAddaV7m.HBxHrwHauyhdVOh3kT4uZiO0Iy4Z
 RhPc5FB0qzt8R3qnryLFLv5LxAnJfeWTavJVgZvF88HlJu7jSqTnebiWBoyKVkMO9n3_csdLLCSV
 VVx2lRu5zizp6GsrsaZanpNAQ2DgVF6HBZR_aLkdO2PAt914cwkcxIhrpG6U0ZKpWOQ2NaonRCA-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 24 Jan 2020 08:06:41 +0000
Date:   Fri, 24 Jan 2020 08:06:36 +0000 (UTC)
From:   Mustafa <sanimustafa87@gmail.com>
Reply-To: mustafasani281@gmail.com
Message-ID: <2029314625.11027103.1579853196873@mail.yahoo.com>
Subject: My good friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2029314625.11027103.1579853196873.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.14873 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:72.0) Gecko/20100101 Firefox/72.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



My good friend,

I just want to know if you, can help me, to transfer the amount of ($6Million). After the transfer we have to share it, 50% for me, and 50% for you. Please let me know if you can help me for more information regarding the transfer. I hope you can work with me honestly?

Thanks.

 Mustafa Sani,
