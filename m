Return-Path: <linux-pm+bounces-9776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4731A912B9B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 18:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50721F27169
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 16:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FD616B395;
	Fri, 21 Jun 2024 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFPqCkgI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B99B1607A4;
	Fri, 21 Jun 2024 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988093; cv=none; b=a9QB5RuhMAn7Vqi96FYO8X3QGU9l5Mn9WRQ+mRPyEDFJSHEO/p7W2G+djKZ042DyVlmRaZEKxG07xXzhcczQKDO7CBJbhn0EBWJLxStVY2rbtEkJW+UG912URWY20c+97I4c31X6IruRkCu7xq/4O53YyO0W5WEynZ442Hda6Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988093; c=relaxed/simple;
	bh=hYmWKI+FNyJcAuG9I3AJi5jO+DJ7u/F46dADwaI+gfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKSV19e4qLcPCHCyYqFFadYKjg+Ht2nZOw3/HCd78vi4XSz7qaWyz1rBzaS2L8ocn1tYxZF59KRU6lVLTwC1Io1X/b8HF3c7PsJh42cRUh1UJJ7kXeKBAQT9q7UBqRUj8tRVWPDQ+obnQDVsVajwVVtjNdGP2DZUc5aKkgOxzck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFPqCkgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCE5C4AF08;
	Fri, 21 Jun 2024 16:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718988093;
	bh=hYmWKI+FNyJcAuG9I3AJi5jO+DJ7u/F46dADwaI+gfI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MFPqCkgIiPane/B29DP24yhmu6Cqx1ig4QHoZu/CxkY/yMoJ3YILzBnO6bkjCzWg4
	 BJgINfW1aYWwyYGosZMqzgu3PzGCmyZEpqoX8WJVZZvA5gYF6geUf237XZQirAljED
	 HG22tgznF9DEGXh4L9IoSzukFhotkAx1inbKvc3jhBvAtNmOTdWnFTnIvlDutybNGW
	 MK9WMuFMPhLXuhADiOdk4AAZQ4+aH5ATHDzqqZCJ3z3C5dfxEe4aqtSz6OZI3ku1B1
	 N8p47W+jeFVuuqqKjL4tDdG1/Bwp8kGZO0FeIGx9litozVLjkKqkqNNdMTXaxH0kOa
	 LX+MC6MAXaHlw==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-25cc44857a1so103814fac.3;
        Fri, 21 Jun 2024 09:41:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0PVnvpVdMujmMzyhdy49w28fhzFjCOoSr5Slu0H+HSEXJXkdr0bBRjYMngK+T2inN3zYVxk6H7qrD45s4i8vBBJ+hHHPsR5h1AS/YIDrxPqT3pnXlBdU3LJ2vert7u+4v4/SvSD4=
X-Gm-Message-State: AOJu0YyxKeXmAsImLOf7v0UerexDiSLdYobpdtgC6mFBn0kF+ydDA61z
	s/3JcCA34XxnQl4ahSMLtDJsfEqHjqahM5EKRsCuAtj7kQ+M+0WX7pSAWY7jv8gibTlptx5nMbY
	5Hvrq70qr+3buutnucw4aaubB/Tk=
X-Google-Smtp-Source: AGHT+IHUjl81JvxOmR4unSTWZ8kAGMURYVE7PROzd8jvdZRqjG9H4e1dW0SiTyIG4FNggeKiHvAbK3c+t8IQitwQT1g=
X-Received: by 2002:a05:6870:148d:b0:258:476d:a781 with SMTP id
 586e51a60fabf-25c94d52e3emr9718943fac.3.1718988092229; Fri, 21 Jun 2024
 09:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZmVfcEOxmjUHZTSX@hovoldconsulting.com> <CAJZ5v0gVnjVyd_O6KgXy2sXr3b3M3vyTLyUCasyxP0GrAXro4Q@mail.gmail.com>
 <CAJZ5v0iz7gwhpvT53CH0ZEA_q3U=dnn6XR8HdLk6LpP3ye4Zkg@mail.gmail.com> <6759ce9f-281d-4fcd-bb4c-b784a1cc5f6e@oldschoolsolutions.biz>
In-Reply-To: <6759ce9f-281d-4fcd-bb4c-b784a1cc5f6e@oldschoolsolutions.biz>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Jun 2024 18:41:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gueSnaci601OkVq9_Ui09k8EsByRL08tFkzDoDGJpp6g@mail.gmail.com>
Message-ID: <CAJZ5v0gueSnaci601OkVq9_Ui09k8EsByRL08tFkzDoDGJpp6g@mail.gmail.com>
Subject: Re: cpufreq/thermal regression in 6.10
To: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Johan Hovold <johan@kernel.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Steev Klimaszewski <steev@kali.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: multipart/mixed; boundary="0000000000009c96e1061b691a44"

--0000000000009c96e1061b691a44
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 21, 2024 at 5:53=E2=80=AFPM Jens Glathe
<jens.glathe@oldschoolsolutions.biz> wrote:
>
> Hi there,
>
> unfortunately I experienced the issue with the fix applied. I had to
> revert this and  the original commit to get back to normal behaviour. My
> system (also Lenovo Thinkpad X13s) uses the schedutil governor, the
> behaviour is as described from Steev and Johan. The full throttling
> happened during a package build and left the performance cores at 940800.

So can you please test the attached patch, on top of the fix?

--0000000000009c96e1061b691a44
Content-Type: text/x-patch; charset="US-ASCII"; name="thermal-gov_step_wise-distangle.patch"
Content-Disposition: attachment; 
	filename="thermal-gov_step_wise-distangle.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lxox3nn60>
X-Attachment-Id: f_lxox3nn60

LS0tCiBkcml2ZXJzL3RoZXJtYWwvZ292X3N0ZXBfd2lzZS5jIHwgICAxOSArLS0tLS0tLS0tLS0t
LS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDE4IGRlbGV0aW9ucygtKQoK
SW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvdGhlcm1hbC9nb3Zfc3RlcF93aXNlLmMKPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQotLS0gbGludXgtcG0ub3JpZy9kcml2ZXJzL3RoZXJtYWwvZ292X3N0ZXBfd2lzZS5jCisrKyBs
aW51eC1wbS9kcml2ZXJzL3RoZXJtYWwvZ292X3N0ZXBfd2lzZS5jCkBAIC01NSw3ICs1NSw3IEBA
IHN0YXRpYyB1bnNpZ25lZCBsb25nIGdldF90YXJnZXRfc3RhdGUoc3QKIAkJaWYgKGN1cl9zdGF0
ZSA8PSBpbnN0YW5jZS0+bG93ZXIpCiAJCQlyZXR1cm4gVEhFUk1BTF9OT19UQVJHRVQ7CiAKLQkJ
cmV0dXJuIGNsYW1wKGN1cl9zdGF0ZSAtIDEsIGluc3RhbmNlLT5sb3dlciwgaW5zdGFuY2UtPnVw
cGVyKTsKKwkJcmV0dXJuIGluc3RhbmNlLT5sb3dlcjsKIAl9CiAKIAlyZXR1cm4gaW5zdGFuY2Ut
PnRhcmdldDsKQEAgLTkzLDIzICs5Myw2IEBAIHN0YXRpYyB2b2lkIHRoZXJtYWxfem9uZV90cmlw
X3VwZGF0ZShzdHIKIAkJaWYgKGluc3RhbmNlLT5pbml0aWFsaXplZCAmJiBvbGRfdGFyZ2V0ID09
IGluc3RhbmNlLT50YXJnZXQpCiAJCQljb250aW51ZTsKIAotCQlpZiAodHJpcC0+dHlwZSA9PSBU
SEVSTUFMX1RSSVBfUEFTU0lWRSkgewotCQkJLyoKLQkJCSAqIElmIHRoZSB0YXJnZXQgc3RhdGUg
Zm9yIHRoaXMgdGhlcm1hbCBpbnN0YW5jZQotCQkJICogY2hhbmdlcyBmcm9tIFRIRVJNQUxfTk9f
VEFSR0VUIHRvIHNvbWV0aGluZyBlbHNlLAotCQkJICogZW5zdXJlIHRoYXQgdGhlIHpvbmUgdGVt
cGVyYXR1cmUgd2lsbCBiZSB1cGRhdGVkCi0JCQkgKiAoYXNzdW1pbmcgZW5hYmxlZCBwYXNzaXZl
IGNvb2xpbmcpIHVudGlsIGl0IGJlY29tZXMKLQkJCSAqIFRIRVJNQUxfTk9fVEFSR0VUIGFnYWlu
LCBvciB0aGUgY29vbGluZyBkZXZpY2UgbWF5Ci0JCQkgKiBub3QgYmUgcmVzZXQgdG8gaXRzIGlu
aXRpYWwgc3RhdGUuCi0JCQkgKi8KLQkJCWlmIChvbGRfdGFyZ2V0ID09IFRIRVJNQUxfTk9fVEFS
R0VUICYmCi0JCQkgICAgaW5zdGFuY2UtPnRhcmdldCAhPSBUSEVSTUFMX05PX1RBUkdFVCkKLQkJ
CQl0ei0+cGFzc2l2ZSsrOwotCQkJZWxzZSBpZiAob2xkX3RhcmdldCAhPSBUSEVSTUFMX05PX1RB
UkdFVCAmJgotCQkJCSBpbnN0YW5jZS0+dGFyZ2V0ID09IFRIRVJNQUxfTk9fVEFSR0VUKQotCQkJ
CXR6LT5wYXNzaXZlLS07Ci0JCX0KLQogCQlpbnN0YW5jZS0+aW5pdGlhbGl6ZWQgPSB0cnVlOwog
CiAJCW11dGV4X2xvY2soJmluc3RhbmNlLT5jZGV2LT5sb2NrKTsK
--0000000000009c96e1061b691a44--

